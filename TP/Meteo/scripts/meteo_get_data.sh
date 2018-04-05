#!/bin/bash


count=0
while read -r input
do
    inputarray=($input)
    mode=${inputarray[0]}
    date=${inputarray[1]}
    day=${date:0:2}
    month=${date:2:2}
    year=${date:4:4}
    prefix=${year}${month}
    station_file=${prefix}station.txt
    daily_file=${prefix}daily.txt
    archive=${prefix}.tar.gz
    archive_new="QCLCD$prefix.zip"
    # We now download the archive if necessary
    if [ ! -f Data/${station_file} ]
    then
	if [ $mode == "0" ]
	then
	    url="http://infomob.metz.supelec.fr/fix/qclcd_ascii/$archive"
	    #url="http://www.ncdc.noaa.gov/orders/qclcd/$archive"
	    echo "Downloading $url" 1>&2
	    wget $url -c -q -P Data
	    echo "Data/$archive downloaded" 1>&2
	    # We then extract the files from the archive
	    # and keep only ${prefix}station.txt and ${prefix}daily.txt
	    cd Data
	    tar -zxf $archive station.txt ${prefix}daily.txt
	    tail -n+2 station.txt | awk -F'|' '{print $1,$10,$11}' > ${station_file}
	    rm -f station.txt
	    cd ..
	else
	    url="http://www.ncdc.noaa.gov/orders/qclcd/$archive_new"
	    echo "Downloading $url" 1>&2
	    wget $url -c -q -P Data
	    echo "Data/$archive_new downloaded" 1>&2
	    # We then extract the files from the archive
	    # and keep only ${prefix}station.txt and ${prefix}daily.txt
	    cd Data
	    unzip -p $archive_new ${prefix}station.txt > station.txt
	    unzip -p $archive_new ${prefix}daily.txt > ${prefix}daily.txt
	    tail -n+2 station.txt | awk -F'|' '{print $1,$10,$11}' > ${station_file}
	    rm -f station.txt
	    cd ..
	fi
    fi
    # We now generate the datafile ${day}${month}${year}.txt
    # by filtering and merging the files ${prefix}station.txt and ${prefix}daily.txt
    
    #### Filtering the relevant data
    # First, we extract all the entries for the current data ${year}${month}${day}
    cat Data/${daily_file} |                                   # Read the daily file
    awk -F, "\$2==${year}${month}${day} { print \$1,\$5 }" |   # Get the measurements of the current day
    awk '$2!="M" && $2 != "-" { print $0 }' |                  # Filter out invalid measures
    sed 's/\*//g' |                                            # Remove the * symbol from the measures
    join Data/${station_file} - > Data/${day}${month}${year}.txt  # And merge with station.txt 
    
    echo "[get_data.sh] Data/${day}${month}${year}.txt generated" 1>&2
    echo "Data/${day}${month}${year}.txt"
done
