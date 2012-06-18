#!/usr/bin/liquidsoap 
# use the -d flag for daemon mode

%include "passwords.liq"

set("log.file",true)
set("log.stdout",false)
set("log.level",3)
#set("harbor.icy",true)
#set("server.telnet",true)
# Enable video 624x352
 set("frame.video.width",624)
 set("frame.video.height",352)

default =  single("say:How are you gentlemen!! 
		     all your base are belong to us. 
		     You are on the way to destruction.                      
		     What you say!!                      
		     You have no chance to survive make your time! 
		     HA! HA! HA! HA! HA!")

video = playlist("/home/edward/micronemez-ogv")

#liveset = mksafe(input.http("http://icecast.micronemez.com:8000/stream")) 
liveset = strip_blank(input.http("http://icecast.micronemez.com:8000/v0"))
liveset = rewrite_metadata([("artist", "FUTURE__DEATH__TOLL"),("title", "LIVE")], liveset) 

radio = fallback(track_sensitive=false,
         [skip_blank(liveset), video, default])


output.icecast.theora( 
  host="icecast.micronemez.com",port=8000,password="hackme", 
  genre="Easy Listening",url="http://micronemez.com", 
  description="pirate video",mount="micronemez_video.ogv", 
  name="FUTURE__DEATH__TOLL ((VIDEO))",radio)

