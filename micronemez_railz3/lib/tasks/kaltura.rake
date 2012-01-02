namespace :kaltura do
	desc "get list of entries from the Kaltura API and populate the KalturaVideo model object"
	task :populate => :environment  do
		
		#how many pages of 30 worth of media entries should we attempt to gather?
		maxPages = 10
		i = 1
		#maxPages.times do |i|
		while i < maxPages	
	    
	    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => i} }
	    entries = Kaltura::MediaEntry.list(@options)
	    
	    entries.each do |a| 
	    	#note the remapping of id, type = mediaId, mediaType
	    	unless KalturaVideo.find_by_mediaId(a.id)
		      kaltura_video = KalturaVideo.new
		      kaltura_video.update_attributes a
		      kaltura_video.mediaId = a.id
		      kaltura_video.mediaType = a.type
		      p a.name
					kaltura_video.save
				else
					#a friendly reminder.
					#TODO: dirty record checking?
					p "#{a.name} exists!"
				end
    	end
			
			if entries.count < 30
				#done.
				i = maxPages
			else 
				i += 1
			end
			
		end
		     
		p "success!"
	end

end
