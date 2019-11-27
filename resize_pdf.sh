#!/bin/bash

# make an equal sizes for pdf, $1 source pdf file where we get size
# $2 dst pdf file which we'll scale to source file, via creating new with appropriate size. 

# we need bc and cpdf installed

OLD_IFS=$IFS;
IFS=$(echo -ne "\n\b");

cpdf='/home/juju/pdf/cpdf-binaries-master/Linux-Intel-64bit/cpdf'

### SOURCE PDF SIZE

source_page_info=$($cpdf -page-info "$1" 2>/dev/null | grep Media | head -1)
#echo $source_page_info

source_width=$(echo $source_page_info | awk '{ print $4 }')
source_height=$(echo $source_page_info | awk '{ print $5 }')


echo -n "source width: "; echo $source_width
echo -n "source height: "; echo $source_height

### DESTINATION PDF SIZE

dst_page_info=$($cpdf -page-info "$2" 2>/dev/null | grep Media | head -1)

dst_width=$(echo $dst_page_info | awk '{ print $4 }')
dst_height=$(echo $dst_page_info | awk '{ print $5 }')

echo -n "dst width: "; echo $dst_width
echo -n "dst height: "; echo $dst_height

### GET RATIO

width_ratio=$(echo "$source_width/$dst_width" | bc -l | cut -c1-10)
height_ratio=$(echo "$source_height/$dst_height" | bc -l | cut -c1-10)

echo -n "width ratio: "; echo $width_ratio;
echo -n "height ratio: "; echo $height_ratio;

### SCALE
$cpdf -scale-page "$width_ratio $height_ratio" $2 -o $2_resized.pdf

IFS=$OLD_IFS;
