#!/bin/bash
#Purpose =  Convert img to pdf with autodetection
#Create on 08-05-2014
#Author = Daniel Amor
#Version 1.0
#START
location="/media/partage/echange/jpegToPdf"
#get folder size
folder_size (){
  echo $(du -c $1 | tail -n1 | cut -f 1)
}
#scan folder and wait for new created file
while inotifywait -e create $location; do
  #check current folder size
  currentSize=$(folder_size $location)
  # still writing?
  while [ $currentSize != $(folder_size $location) ]; do
     currentSize=$(folder_size $location)
     sleep 1
  done
  #convert
  /usr/bin/convert -strip -interlace Plane -resize 80% -sharpen 0x.6 -quality 80% $location/*.jpg $location/converted.pdf
done
#END
