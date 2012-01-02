module ApplicationHelper

	#handy, but otherwise unused helpaa
	def arr_to_hash(arr)
		h={}; arr.each { |k,v| h[k]=v }
		return h
	end

end
