class KalturaVideo < ActiveRecord::Base

	public 

	def getContentFromAPI
	
		entries = Kaltura::MediaEntry.list
	
		#TODO: check to see if record already exists... 
		# need to account for single changes in each key value...
		entries.each do |a|
    	kaltura_video = KalturaVideo.new
   		kaltura_video.update_attributes a
  		kaltura_video.save
		end
	
	end

end
