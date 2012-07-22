namespace :kaltura do    
	newHost = ENV["HOST"] || "http://micronemez.com"
	kalturaHost = "http://video.vonsor.com" 
	height = ENV["HEIGHT"] || "330"
	justOne = ENV["JUSTONE"] || false
	
  desc "non-destructive Kaltura API connection test"
	task :test_connection => :environment  do
    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => 1} }
	  entries = Kaltura::MediaEntry.list(@options)
      
    p entries.last
    p "LAST ONE"
	  entries.last do |a| 
      #p "do a "
	  	#note the remapping of id, type = mediaId, mediaType
		  unless KalturaVideo.find_by_mediaId(a.id)
			  kaltura_video = KalturaVideo.new
			  kaltura_video.update_attributes a
			  kaltura_video.mediaId = a.id
			  kaltura_video.mediaType = a.type
			  p "#{a.id}  #{a.type}  {a.name}"
				#kaltura_video.save!
				p "DONE"
        vsaved+=1
			else
				#a friendly reminder.
				#TODO: dirty record checking?
				p "video #{a.name} exists!"
			end #unless
	  end #entries.last

  end
  
	desc "get list of entries from the Kaltura API and populate the Video model object"
	task :populate => :environment  do
		
		#how many pages of 30 worth of media entries should we attempt to gather?
		maxPages = 100
		i = 1
		vsaved=0
	    
		#maxPages.times do |i|
		while i < maxPages	
	    
	    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => i} }
	    entries = Kaltura::MediaEntry.list(@options)
	    #p entries.inspect
		  entries.each do |a| 
		  	#note the remapping of id, type = mediaId, mediaType
			  unless KalturaVideo.find_by_mediaId(a.id)
				  kaltura_video = KalturaVideo.new
				  kaltura_video.update_attributes a
				  kaltura_video.mediaId = a.id
				  kaltura_video.mediaType = a.type
				  p a.name
					kaltura_video.save!
          
          #fill in the Video Object too
          video = Video.new
          video.updated_at = Time.now
          video.description = a.description
          video.title = a.name
          video.kaltura_mediaId = a.id
          video.thumbnail_url = a.thumbnailUrl
          p video.title
          video.save!
          
					vsaved+=1
				else
					#a friendly reminder.
					#TODO: dirty record checking?
					p "video #{a.name} exists!"
				end #find
	    end #entries
			
			if entries.count < 30
				#done.
				i = maxPages
			else 
				i += 1
			end
			
		end
		
		p "success!"
		p "#{vsaved} videos saved. "     
		
	end

	desc "destroy everything"
	task :destroyEverything => :environment  do	
   
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} kalturavideos destroy'd. "  
	end

	desc "destroy video"
	task :destroyVideo => :environment  do
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} videos destroy'd. "  
	end
	
	desc "destroy video thumbnails"
	task :destroyVideoThumbnails => :environment  do
		v = KalturaVideo.find(:all)
    v.each do |vv| 
      video = Video.find_by_kaltura_mediaId(vv.mediaId).thumbnail_saveto
      if File.exist?("#{video}") 
        p "VIDEO FILE FOUND. CAN BE DESTROYED? #{video} "
        p "type yes"
        areyousure = $stdin.gets.chomp
        if areyousure == "yes"
          File.delete(video)
          #destroy it here by convenience 
          vv.destroy
          p "DELETED&DESTROYED"
        end
      else 
        p "try to destroy? type yes"
        areyousure = $stdin.gets.chomp
        if areyousure == "yes"
          vv.destroy
          p "DESTROYED"
        end
      end
    end
		  
		p "success! (perhaps?)"
		p "#{v.count} videos destroy'd. "  
	end
	
	desc "download video thumbnailz to public/images"
	task :getVideoThumbnails => :environment do
		require 'uri'
		require 'net/http'
		include ApplicationHelper
		v = KalturaVideo.find(:all)

		v.each do |video|
			uri = URI(video.thumbnailUrl)
			uriNewHost = URI(newHost)
      sani_fresh = video.mediaId + '.jpg'
			saveto = "#{Rails.root}/public/images/#{sani_fresh}"
			newDownloadUrl = "#{newHost}/images/#{sani_fresh}"
        
			unless !File.exist?(saveto) 
				puts "#{video.downloadUrl} has already been downloaded"
			end #unless
        #TODO: implement dynamic extensions			
				
				
        newVideo = Video.new
				
				Net::HTTP.start(uri.host) do |http|
						newHeight = "#{video.thumbnailUrl}/height/#{height}"
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
        
        # switch over to the plain Video object and save some attrz there
        # probably no update_attributes here, eh?
        newVideo = Video.find_by_kaltura_mediaId(video.mediaId)
				#newVideo.update_attributes video
        newVideo.updated_at = Time.now
        newVideo.thumbnail_saveto = saveto
        newVideo.thumbnail_url = newDownloadUrl
        #TODO:
        #newVideo.file_saveto
        #newVideo.file_pub_url
        #newVideo.file_cdn_url
        # TRY !
        newVideo.save!
        
        #video.thumbnailUrl = newDownloadUrl				
				# TRY ! ON THE KALTURA |VIDEO|
        video.updated_at = Time.now
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
				
        # switch over to the plain Audio object and save some attrz there
        newAudio = Audio.new
				newAudio.update_attributes video
        newAudio.saveto = saveto
        #TODO: audio thumbnail?
        newAudio.thumbnailUrl = newDownloadUrl
        # TRY !
        newAudio.save!
        
        audio.downloadUrl = newDownloadUrl
				audio.save!
				puts "updated db #{newDownloadUrl}"
			else 
			#friendly reminder
				puts "#{audio.downloadUrl} has already been downloaded"
			end
		end
		puts "done."
	end #task

  desc "destroy video files"
	task :destroyVideoFiles => :environment  do
		v = KalturaVideo.find(:all)
    v.each do |vv| 
      # this is raddy-taddy (refactor?)
      video = Video.find_by_kaltura_mediaId(vv.mediaId).file_saveto
      if File.exist?(video) 
        p "VIDEO FILE FOUND. CAN BE DESTROYED? #{video} "
        p "type yes"
        areyousure = $stdin.gets.chomp
        if areyousure == "yes"
          File.delete(video)
          vv.destroy
          p "DELETED"
        end
      else 
        p "try to destroy? type yes"
        areyousure = $stdin.gets.chomp
        if areyousure == "yes"
          vv.destroy
          p "DESTROYED"
        end
      end
      
    end
		  
		p "success! (perhaps?)"
		p "#{v.count} videos destroy'd. "  
	end
	
	desc "download video thumbnailz to public/images"
	task :getVideoThumbnails => :environment do
		require 'uri'
		require 'net/http'
		include ApplicationHelper
		v = KalturaVideo.find(:all)

		v.each do |video|
			uri = URI(video.thumbnailUrl)
			uriNewHost = URI(newHost)
      sani_fresh = video.mediaId + '.jpg'
			saveto = "#{Rails.root}/public/images/#{sani_fresh}"
			newDownloadUrl = "#{newHost}/images/#{sani_fresh}"
        
			unless !File.exist?("#{saveto}") 
				puts "#{video.downloadUrl} has already been downloaded"
			end #unless
        #TODO: implement dynamic extensions			
				
				
        newVideo = Video.new
				
				Net::HTTP.start(uri.host) do |http|
						newHeight = "#{video.thumbnailUrl}/height/#{height}"
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
        
        # switch over to the plain Video object and save some attrz there
        # probably no update_attributes here, eh?
        newVideo = Video.find_by_kaltura_mediaId(video.mediaId)
				#newVideo.update_attributes video
        newVideo.updated_at = Time.now
        newVideo.thumbnail_saveto = saveto
        newVideo.thumbnail_url = newDownloadUrl
        #TODO:
        #newVideo.file_saveto
        #newVideo.file_pub_url
        #newVideo.file_cdn_url
        # TRY !
        newVideo.save!
        
        #video.thumbnailUrl = newDownloadUrl				
				# TRY ! ON THE KALTURA |VIDEO|
        video.updated_at = Time.now
        video.save!
				puts "updated db #{newDownloadUrl}"
			
		end #each
		puts "done."
	end #task


end

