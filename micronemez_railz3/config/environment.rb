# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Micronemez::Application.initialize!

#time magic that allows us to use things like this: some_model.created_at.to_s(:short)
#%a, %b %e, %Y, %l:%M%P
DateTime::DATE_FORMATS[:short]="%b %Y"
Time::DATE_FORMATS[:short] = "%b %Y"
Date::DATE_FORMATS[:short] = "%b %Y"

DateTime::DATE_FORMATS[:joined]="%a, %b %e, %Y, %l:%M%P"
Time::DATE_FORMATS[:joined] = "%a, %b %e, %Y, %l:%M%P"
Date::DATE_FORMATS[:joined] = "%a, %b %e, %Y, %l:%M%P"

def yell(msg)
  f = File.open(File.expand_path(File.dirname(__FILE__) + "/../log/yell.log"), "a")
  f.puts msg
  f.close
end

def stringToJsonHash(str)
  yell "STR #{str}"
  lazy = lambda { |h,k| h[k] = Hash.new(&lazy) }
  h = Hash.new(&lazy)
  #"foo, bar, baz".split(/,/).each_with_index {|item, index| h[index]=item }
  str.split(/, /).each_with_index {|item, index| h[index]=item }
  hmap = h.map{|k, v| {:id => k, :name => v }}
  out = hmap.to_json
    
end
