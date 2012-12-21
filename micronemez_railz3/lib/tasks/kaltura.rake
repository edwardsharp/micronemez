namespace :kaltura do    
	newHost = ENV["HOST"] || "http://micronemez.com"
	kalturaHost = "http://video.micronemez.com" 
	height = ENV["HEIGHT"] || "330"
	justOne = ENV["JUSTONE"] || false
	
  desc "non-destructive Kaltura API connection test"
	task :test_connection => :environment  do
    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => 1} }
	  entries = Kaltura::MediaEntry.list(@options)
      
    p entries.last
    p "LAST ONE IS"
	  entries.last do |a| 
	  	#note the remapping of id, type = mediaId, mediaType
		  unless KalturaVideo.find_by_mediaId(a.id)
			  kaltura_video = KalturaVideo.new
			  kaltura_video.update_attributes a
			  kaltura_video.mediaId = a.id
			  kaltura_video.mediaType = a.type
			  p "#{a.id}  #{a.type}  {a.name}"
				p "DONE"
        vsaved+=1
			else
				p "video #{a.name} exists!"
			end #unless
	  end #entries.last
  end #task
  
	desc "get list of entries from the Kaltura API and populate the Video model object"
	task :populate => :environment  do
    #some constantz
    VIDEO_MEDIA_TYPE = "1"
    AUDIO_MEDIA_TYPE_MP3 = "5"
    BASE_CATEGORY = "mcrnmz"
    
		#how many pages of 30 worth of media entries should we attempt to gather?
		maxPages = 100
		i = 1
		vsaved=0
    asaved=0
	    
		while i < maxPages	
	    #TODO: build in cache mechnism so that updates can be checked without writing to db
	    @options = { :pager => { :orderBy => "%2BcreatedAt", :pageIndex => i } }
	    entries = Kaltura::MediaEntry.list(@options)
      p "-FOUND #{entries.count} entries. "
		  entries.each do |entry| 
        p "--ENTRY---entry.mediaType: #{entry.mediaType}---BASE_CATEGORY #{BASE_CATEGORY}---entry.categories #{entry.categories}"
        #DETERMINE CATEGORY TYPE AND THUS OBJECT TYPE FOR INIT
        #TODO: actually tag video files as a category in kaltura
        #TODO: make this an easier-to-configure option...
        #next unless entry.categories =~ /#{BASE_CATEGORY}/
        case entry.mediaType
        when VIDEO_MEDIA_TYPE
          p "---FOUND A VIDEO_MEDIA_TYPE: #{VIDEO_MEDIA_TYPE}!"
		  	  #note the remapping of id, type = mediaId, mediaType
			    unless KalturaVideo.find_by_mediaId(entry.id)
  				  kaltura_video = KalturaVideo.new
  				  kaltura_video.update_attributes entry
  				  kaltura_video.mediaId = entry.id
            #be explicit-y about this one!
  				  kaltura_video.mediaType = entry.mediaType
  				  p entry.name
  					kaltura_video.save!
            
            #fill in the Video Object too
            video = Video.new
            video.updated_at = Time.now
            #TODO: toggle preferences? 
            video.description = entry.description
            video.title = entry.name
            video.kaltura_mediaId = entry.id
            video.thumbnail_url = entry.thumbnailUrl
            #p video.title
            video.save!
            p "+++NEW VIDEO ENTRY: #{entry.name}"
  					vsaved+=1
				  else
					  #a friendly reminder, plz mind the unlesselse
					  #TODO: dirty record checking?
					  p "=== video #{entry.name} exists!"
				  end #unlesselse
        when AUDIO_MEDIA_TYPE_MP3
          p "---FOUND AN AUDIO_MEDIA_TYPE_MP3: #{AUDIO_MEDIA_TYPE_MP3}!"
          #note the remapping of id, type = mediaId, mediaType
			    unless KalturaAudio.find_by_mediaId(entry.id)
  				  kaltura_audio = KalturaAudio.new
  				  kaltura_audio.update_attributes entry
  				  kaltura_audio.mediaId = entry.id
            #be explicit-y about this one!
  				  kaltura_audio.mediaType = entry.mediaType
  				  p entry.name
  					kaltura_audio.save!
            p "+++NEW AUDIO ENTRY: #{entry.name}"
            #TODO: create audio object model...
            #fill in the Audio Object too
            audio = Audio.new
            audio.updated_at = Time.now
            #TODO: toggle preferences? 
            audio.description = entry.description
            audio.title = entry.name
            audio.kaltura_mediaId = entry.id
            audio.thumbnail_url = entry.thumbnailUrl
            audio.save!
  					
            asaved+=1
				  else
					  #a friendly reminder, plz mind the unlesselse
					  #TODO: dirty record checking?
					  p "! audio #{entry.name} exists!"
				  end #unlesselse
        else 
          p "! UNKNOWN ENTRY MEDIATYPE: #{entry.mediaType}!"
        end #case whenelse
        
	    end #entries
			
      # less than 30 entries would mean a partial page and thus no more entries...
			if entries.count < 30
				# done.
				i = maxPages
			else 
				i += 1
			end
			
		end
		
		p "-success #{vsaved} videos saved, #{asaved} audios saved. "
    
    p "try and download video thumbnails? (type yes)"
    areyousure = $stdin.gets.chomp
    if areyousure == "yes"
      Rake::Task["kaltura:getVideoThumbnails"].execute
    end #areyousure	
	end #task
	
	desc "download video thumbnailz to public/images"
	task :getVideoThumbnails => :environment do
    #START THE CHAIN SAWWWW
		require 'uri'
		require 'net/http'
    require 'file'
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
		p "DONE"
    p "try and download audio files? (type yes)"
    areyousure = $stdin.gets.chomp
    if areyousure == "yes"
      Rake::Task["kaltura:getAudioFiles"].execute
    end #areyousure	
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
				sani_fresh = "#{audio.mediaId}.mp3"
				saveto = "#{Rails.root}/public/audio/#{sani_fresh}"
				newDownloadUrl = "#{newHost}/audio/#{sani_fresh}"
				p "connecting to #{uri}"
				Net::HTTP.start(uri.host) do |http|
				    resp = http.get(audio.downloadUrl)
				    if resp.response['Location']!=nil then
						  puts "redirecting to: #{resp.response['Location']}"
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
				newAudio.title = audio.name
        #newAudio.update_attributes audio
        newAudio.file_saveto = saveto
        #TODO: audio thumbnail?
        newAudio.file_pub_url = newDownloadUrl
        # TRY !
        newAudio.save!
        
        #audio.downloadUrl = newDownloadUrl
				#audio.save!
				##puts "updated db #{newDownloadUrl}"
			else 
			#friendly reminder
				puts "#{audio.downloadUrl} has already been downloaded"
			end
		end
		p "DONE"
    p "try and download video files? (type yes)"
    areyousure = $stdin.gets.chomp
    if areyousure == "yes"
      Rake::Task["kaltura:getVideoFiles"].execute
    end #areyousure	
	end #task
	
	desc "download video filez to public/videos"
	task :getVideoFiles => :environment do
		require 'uri'
		require 'net/http'
    #require 'file'
		include ApplicationHelper
    #newHost
    v = KalturaVideo.find(:all)
    
		v.each do |video|
      next unless video.downloadUrl
      
			uri = URI(video.downloadUrl)
      #MUST GET EXTENSION RIGHT. GET IT FROM URI??
      #settle on mp4 for now because ffmpeg will save the day (as usual)
      #sani_fresh = File.basename(URI(newHost).path)
			sani_fresh = "#{video.mediaId}.mp4"
      saveto = "#{Rails.root}/public/video/#{sani_fresh}"
			newDownloadUrl = "#{newHost}/video/#{sani_fresh}"
        
			unless !File.exist?("#{saveto}") 
				puts "#{video.downloadUrl} has already been downloaded"
			end #unless
        #TODO: implement dynamic extensions			
        newVideo = Video.new
				
				Net::HTTP.start(uri.host) do |http|
				    p "connecting to #{video.downloadUrl}"
				    resp = http.get(video.downloadUrl)
				    if resp.response['Location']!=nil then
						  puts "redirecting to: #{resp.response['Location']}"
						  redirectUrl= "#{resp.response['Location']}/height/#{height}"
						  resp = http.get(redirectUrl)
						end
						
						#TODO: better file-already-exists inspection, md5sum or simmilar? 
						# does the resp need to be downloaded to get a FileTest.size ???
				    open(saveto, "wb") do |file|
					      file.write(resp.body)
					  end
				end #Net HTTP
				puts "saved to #{saveto} "
        
        # switch over to the plain Video object and save some attrz there
        # probably no update_attributes here, eh?
        newVideo = Video.find_by_kaltura_mediaId(video.mediaId)
				#newVideo.update_attributes video
        newVideo.updated_at = Time.now
        newVideo.file_saveto = saveto
        newVideo.file_pub_url = newDownloadUrl
        #TODO:
        #newVideo.file_cdn_url
        # TRY !
        newVideo.save!
        
        #video.thumbnailUrl = newDownloadUrl				
				# TRY ! ON THE KALTURA |VIDEO|
        video.updated_at = Time.now
        video.save!
				puts "updated db #{newDownloadUrl}"
			
		end #each
		puts "ITZ OVER!"
	end #task

  # D E S T R O Y [DESTRUCTORZ]
  desc "destroy everything"
	task :destroyEverything => :environment  do	
   
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} kalturavideos destroy'd. "  
	end #task

	desc "destroy video"
	task :destroyVideo => :environment  do
		v = KalturaVideo.find(:all)
		vvv = v.count
		v.each{ |vv| vv.destroy }
		
		p "success! (perhaps?)"
		p "#{vvv} videos destroy'd. "  
	end #task

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
	end #task 
  
  desc "destroy audios that donot have a url"
	task :getVideoThumbnails => :environment do
    a = Audio.find(:all)
    
    a.each do |audio|
      if audio.file_pub_url.nil?
        p "#{audio.file_pub_url}"
        #audio.destroy
      end
    end
  end #task
  
end