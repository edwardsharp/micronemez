module ApplicationHelper

	#handy, but otherwise unused helpaa
	def arr_to_hash(arr)
		h={}; arr.each { |k,v| h[k]=v }
		return h
	end
	
	def sanitize_filename(filename)
	   filename.gsub! /^.*(\\|\/)/, ''
	   # replace all non alphanumeric, underscore 
	   # or periods with underscore
	   # name.gsub! /[^\w\.\-]/, '_'
	   # strip out the non-ascii alphabets too 
	   # and replace with x. yes. x.
	   filename.gsub!(/[^0-9A-Za-z.\-]/, 'x')
	  
	  return filename
	end

end
