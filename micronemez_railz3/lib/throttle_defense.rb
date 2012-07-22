# lib/throttle_defense.rb
# thx http://martinciu.com/2011/08/how-to-add-api-throttle-to-your-rails-app.html
require 'rack/throttle'
# attempt to limit abuse
class ThrottleDefense < Rack::Throttle::Daily

  def initialize(app)
    host, port, db = YAML.load_file(File.dirname(__FILE__) + '/../config/redis.yml')[Rails.env].split(':')
    options = {
      # we already use Redis in our app, so we reuse it's 
      # config file here
      :cache => Redis.new(:host => host, :port => port, :thread_safe => true, :db => db),
      # if you use staging environment on the same redis server
      # it is good to have separete key prefix for this
      :key_prefix => "micronemez:#{Rails.env}:throttle_defense",
      # only 5000 request per day
      :max => 5000
    }
    @app, @options = app, options
  end

  # this method checks if request needs throttling. 
  # If so, it increases usage counter and compare it with maximum 
  # allowed API calls. Returns true if a request can be handled.
  def allowed?(request)
    need_defense?(request) ? cache_incr(request) <= max_per_window : true
  end

  def call(env)
    status, heders, body = super
    request = Rack::Request.new(env)
    # just to be nice for our clients we inform them how many
    # requests remaining does they have
    if need_defense?(request)
      heders['X-RateLimit-Limit']     = max_per_window.to_s
      heders['X-RateLimit-Remaining'] = ([0, max_per_window - (cache_get(cache_key(request)).to_i rescue 1)].max).to_s
    end
    [status, heders, body]
  end

  # rack-throttle can use many backends for storing request counter.
  # We use Redis only so we can use it's features. In this case 
  # key increase and key expiration
  def cache_incr(request)
    key = cache_key(request)
    count = cache.incr(key)
    cache.expire(key, 1.day) if count == 1
    count
  end

  protected
    # only some calls should be throttled
    def need_defense?(request)
      request.host == API_HOST
    end

end