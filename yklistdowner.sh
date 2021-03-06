#!/bin/bash
#===============================================================================
#
#          FILE:  yklistdowner.sh
# 
#         USAGE:  ./yklistdowner.sh url 
# 
#   DESCRIPTION:  To download all videos in youku playlist
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Lichi Zhang (), tigerdavidxeon@gmail.com
#       COMPANY:  University of York, UK
#       VERSION:  0.7
#       CREATED:  02/05/2012 01:52:26 AM GMT
#      REVISION:  ---
#===============================================================================

# num=$(wc -l < XMTk3Mzk3MjUy.down);for ((i=8;i<=$num;i++)); do url=$(sed -n "$i"'p' < XMTk3Mzk3MjUy.down).html;../ykdowner.sh $url;done
pid=$(echo $1 | sed "s/.*id_\(.*\).html/\1/")
mkdir $pid;cd $pid; # create a temp folder to download the videos
curl -o $pid.html $1
cat $pid".html" | grep "v_playlist\|\/v_show\/id" | sed "s/.*href=\"\(.*\).html.*/\1/" | sed -e '/douban/d' -e '/sohu/d' -e '/profile/d' -e '/article/d' -e '/share/d' -e '/class/d' > temp.down
uniq temp.down > $pid.down
rm temp.down

num=$(wc -l < $pid".down")
for ((i=1;i<$num;i++))
do
	echo "Start No.$i video"
	url=$(awk "NR==$i" $pid".down").html
	../ykdowner.sh $url
done
