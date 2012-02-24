namespace :kaltura do    
	newHost = ENV["HOST"] || "http://micronemez.com"
	kalturaHost = "http://video.micronemez.com" 
	height = ENV["HEIGHT"] || "330"
	justOne = ENV["JUSTONE"] || false
	
	desc "get list of entries from the Kaltura API and populate the KalturaVideo model object"
	task :populate => :environment  do
		
		#how many pages of 30 worth of media entries should we attempt to gather?
		maxPages = 10
		i = 1
		vsaved=0
	  asaved=0
	    
		#maxPages.times do |i|
		while i < maxPages	
	    
	    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => i} }
	    entries = Kaltura::MediaEntry.list(@options)
	    
	    #justOne is kind of silly and not at all DRY
	    # NOTE TO SELF: DONOT TELL ANYONE YOUARE NOT DRY!
	    if justOne 
	    	entries.last do |a| 
	    	#note the remapping of id, type = mediaId, mediaType
	    	if a.categories =~ /mcrnmz/
		    	if a.categories =~ /video/ 	
			    	unless KalturaVideo.find_by_mediaId(a.id)
				      kaltura_video = KalturaVideo.new
				      kaltura_video.update_attributes a
				      kaltura_video.mediaId = a.id
				      kaltura_video.mediaType = a.type
				      p a.name
							kaltura_video.save!
							vsaved+=1
						else
							#a friendly reminder.
							#TODO: dirty record checking?
							p "video #{a.name} exists!"
						end
					
		    	elsif a.categories =~ /audio/
			    	unless KalturaAudio.find_by_mediaId(a.id)
				      kaltura_audio = KalturaAudio.new
				      kaltura_audio.update_attributes a
				      kaltura_audio.mediaId = a.id
				      kaltura_audio.mediaType = a.type
				      p a.name
							kaltura_audio.save!
							asaved+=1
						else
							#a friendly reminder.
							#TODO: dirty record checking?
							p "audio #{a.name} exists!"
						end 
		    	end #video/audio
	    	end #mcrnmz
    	end #entries
	    
	    else
	    
		    entries.each do |a| 
		    	#note the remapping of id, type = mediaId, mediaType
		    	#if a.categories =~ /mcrnmz/
			    	if a.categories =~ /video/ 	
				    	unless KalturaVideo.find_by_mediaId(a.id)
					      kaltura_video = KalturaVideo.new
					      kaltura_video.update_attributes a
					      kaltura_video.mediaId = a.id
					      kaltura_video.mediaType = a.type
					      p a.name
								kaltura_video.save!
								vsaved+=1
							else
								#a friendly reminder.
								#TODO: dirty record checking?
								p "video #{a.name} exists!"
							end
						
			    	elsif a.categories =~ /audio/
				    	unless KalturaAudio.find_by_mediaId(a.id)
					      kaltura_audio = KalturaAudio.new
					      kaltura_audio.update_attributes a
					      kaltura_audio.mediaId = a.id
					      kaltura_audio.mediaType = a.type
					      p a.name
								kaltura_audio.save!
								asaved+=1
							else
								#a friendly reminder.
								#TODO: dirty record checking?
								p "audio #{a.name} exists!"
							end 
			    	end #video/audio
		    	#end #mcrnmz
	    	end #entries
			end #if/else crappp
			
			if entries.count < 30
				#done.
				i = maxPages
			else 
				i += 1
			end
			
		end
		
		p "success!"
		p "#{vsaved} videos saved. #{asaved} audios saved. "     
		
	end

	desc "destroy everything"
	task :destroyEverything => :environment  do	
   

		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		a = KalturaAudio.find(:all)
		aaa = a.count
		a.each{ |aa| aa.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} videos destroy'd. #{aaa} audios destroy'd. "  
	end

	desc "destroy video"
	task :destroyVideo => :environment  do
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} videos destroy'd. "  
	end

	desc "destroy audio"
	task :destroyAudio => :environment  do
		a = KalturaAudio.find(:all)
		aaa = a.count
		a.each{ |aa| aa.destroy }
		
		p "success! (perhaps?)"
		p "#{aaa} audios destroy'd. "  
	end
	
	desc "destroy video thumbnails"
	task :destroyVideoThumbnails => :environment  do
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} videos destroy'd. "  
	end

	
	desc "download video thumbnailz to public/images"
	task :getVideoThumbnails => :environment do
		#require 'uri'
		require 'net/http'
		include ApplicationHelper
		v = KalturaVideo.find(:all)
	
		v.each do |video|
			uri = URI(video.thumbnailUrl)
			
			uriNewHost = URI(newHost)
			unless uri.host != uriNewHost.host
				puts "#{video.downloadUrl} has already been downloaded"
			end #unless
			
				sani_fresh = sanitize_filename(video.mediaId) + '.jpg'
				saveto = "#{Rails.root}/public/images/#{sani_fresh}"
				newDownloadUrl = "#{newHost}/images/#{sani_fresh}"
				
				
				Net::HTTP.start(uri.host) do |http|
						newHeight = "#{kalturaHost}#{uri.path}/height/#{height}"
				    p "connecting to #{newHeight}"
				    resp = http.get(newHeight)
				    if resp.response['Location']!=nil then
						  puts 'redirecting to: ' + resp.response['Location']
						  redirectUrl= "#{resp.response['Location']}/height/#{height}"
						  resp = http.get(redirectUrl)
						end
						
						#TODO: better file-already-exists inspection, md5sum or simmilar? 
						# does the resp need to be downloaded to get a FileTest.size ???
						#catches zero-byte filez
				    #if FileTest.size?(saveto) == 0 				    
					    open(saveto, "wb") do |file|
					        file.write(resp.body)
					    end
					  #else
					  	#friendly reminder.
					  #	puts "zero-byte file"
					  #end
					  
				end
				puts "saved to #{saveto} "
				video.thumbnailUrl = newDownloadUrl				
				video.save!
				puts "updated db #{newDownloadUrl}"
			
		end #each
		puts "done."
	end #task


	desc "download audio to public/audio"
	task :getAudioFiles => :environment do
		#require 'uri'
		require 'net/http'
		include ApplicationHelper
		
		a = KalturaAudio.find(:all)
	
		a.each do |audio|
			uri = URI(audio.downloadUrl)
			uriNewHost = URI(newHost)
			unless uri.host == uriNewHost.host
				#TODO: use a more dynamic filename.
				sani_fresh = sanitize_filename(audio.mediaId) + '.mp3'
				saveto = "#{Rails.root}/public/audio/#{sani_fresh}"
				newDownloadUrl = "#{newHost}/audio/#{sani_fresh}"
				p "connecting to #{uri}"
				Net::HTTP.start(uri.host) do |http|
				    resp = http.get(uri.path)
				    if resp.response['Location']!=nil then
						  puts 'redirecting to: ' + resp.response['Location']
						  redirectUrl=resp.response['Location']
						  resp = http.get(redirectUrl)
						end
				    
				    open(saveto, "wb") do |file|
				        file.write(resp.body)
				    end
				end
				puts "saved to #{saveto} "
				audio.downloadUrl = newDownloadUrl
				audio.save!
				puts "updated db #{newDownloadUrl}"
			else 
			#friendly reminder
				puts "#{audio.downloadUrl} has already been downloaded"
			end
		end
		puts "done."
	end

end

