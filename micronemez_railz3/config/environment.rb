# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Micronemez::Application.initialize!

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
