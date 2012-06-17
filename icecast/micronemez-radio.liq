#!/usr/bin/liquidsoap 
# use the -d flag for daemon mode

%include "passwords.liq"

set("log.file",true)
set("log.stdout",false)
set("log.level",3)
set("harbor.icy",true)
set("server.telnet",true)

default =  single("say:How are you gentlemen!! 
		     all your base are belong to us. 
		     You are on the way to destruction.                      
		     What you say!!                      
		     You have no chance to survive make your time! 
		     HA! HA! HA! HA! HA!")

jingles = playlist("/home/edward/micronemez-jinglez") 

audio = playlist("/home/edward/micronemez-ogg")

mp3Audio = playlist("/var/www/YELLOW_HOUSE/nicecast")

#liveset = mksafe(input.http("http://audio.micronemez.com:8000/stream")) 
liveset = strip_blank(input.http("http://audio.micronemez.com:8000/stream"))
liveset = rewrite_metadata([("artist", "FUTURE__DEATH__TOLL"),("title", "LIVE FROM YELLOW_HOUSE")], liveset) 

radio = fallback(track_sensitive=false,
         [skip_blank(liveset), audio, default])

radio = random(weights=[1,5],[ jingles, radio ]) 

mp3Radio = fallback(track_sensitive=false,
	[skip_blank(liveset), mp3Audio, default])

mp3Radio = random(weights=[1,5],[ jingles, mp3Radio ])

output.icecast.lame(
  host="audio.micronemez.com",port=8000,password="hackme",
  genre="Easy Listening",url="http://audio.micronemez.com",
  description="pirate radio",mount="micronemez-radio.mp3",
  name="FUTURE__DEATH__TOLL ((YELLOW_HOUSE))",mp3Radio)


output.icecast.vorbis( 
  host="audio.micronemez.com",port=8000,password="hackme", 
  genre="Easy Listening",url="http://audio.micronemez.com", 
  description="pirate radio",mount="micronemez-radio.ogg", 
  name="FUTURE__DEATH__TOLL ((YELLOW_HOUSE))",radio)
