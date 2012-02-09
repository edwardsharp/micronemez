#!/bin/bash

echo -n "what audio extension to search for? "
read sext

echo -n "what audio codec to render? "
read codec

echo -n "what extension to render? "
read rext

for i in *.$sext;
	do name=`echo $i | cut -d'.' -f1`;
	echo $name;
	ffmpeg -i $name.$sext -acodec $codec -aq 60 $name.$rext
done
