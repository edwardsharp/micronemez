namespace :kaltura do

	desc "get list of entries from the Kaltura API and populate the KalturaVideo model object"
	task :populate do
	
	  entries = Kaltura::MediaEntry.list
	  
	    #TODO: check to see if record already exists... 
	    # need to account for single changes in each key value...
	    entries.each do |a| 
	      kaltura_video = KalturaVideo.new
	      kaltura_video.update_attributes a
	      p a.name
				kaltura_video.save
	    end 
	p "success!"
	end

end
