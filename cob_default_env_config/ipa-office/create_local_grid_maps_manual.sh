#!/bin/bash
# global properties of the ipa-office-map:
globalmap="map.pgm"
sizex=1939
sizey=1398
resolution=0.025
resolution=25
originx=628
originy=807


# starting point top-left of cropping area:
left=539
top=912
#dimension of cropping area:
width=159
height=281

# settings for path and local grid map store folder
path_of_gridmaps="./local_grid_maps/"
file_of_gridmaps="local_maps.yaml"
templ_of_gridmaps="local_map_"
type_of_gridmaps=".pgm"

#parameter via call
if [ $# != 4 ]
  then
	echo "please give four parameters to create local grid maps. e.g. './create_local_grid_maps_manual.sh left top width height'"
  else
        # count existent grid maps
        picture_id=0
	while [ -f $path_of_gridmaps$templ_of_gridmaps$picture_id$type_of_gridmaps ] ; do
		((picture_id++))
	done

	# crop area from global map
	left=$1
	top=$2
	width=$3
	height=$4
	convert $globalmap -crop $width"x"$height"+"$left"+"$top $path_of_gridmaps$templ_of_gridmaps$picture_id$type_of_gridmaps

	origin_mil_x=$((($left - $originx) * $resolution))
	origin_mil_y=$((($originy-($top+$height)) * $resolution))
	echo "  - id: "$picture_id >> $path_of_gridmaps$file_of_gridmaps
	echo "    image: "$templ_of_gridmaps$picture_id$type_of_gridmaps >> $path_of_gridmaps$file_of_gridmaps
	echo "    origin: ["$((origin_mil_x/1000))"."$((origin_mil_x<0?(-origin_mil_x%1000):origin_mil_x%1000))", "$((origin_mil_y/1000))"."$((origin_mil_y<0?(-origin_mil_y%1000):origin_mil_y%1000))", 0]" >> $path_of_gridmaps$file_of_gridmaps
fi

