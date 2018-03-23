 #!/bin/bash
url_arg=$1
directory=$2
limit=$3
counter=1
if [ -z "$3" ] && ! [ -z "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null ; then
limit=$2
directory=""
fi
if [[ $url_arg = *"{0}"* ]];
then
	url=${url_arg/\{0\}/$counter}
	if [ -z "$url_arg" ]
	then 
		printf "Please provide the feed multipage URL\n"
	else
		fullfilename=$(basename $url_arg)
		if [ -z "$directory" ]; then
			directory=$(pwd)
			filename="${fullfilename%.*}"
			filename=${filename/\{0\}/multipage_feed}
			directory="$directory/$filename"
		fi
			extension="${fullfilename##*.}"
			mkdir -p "$directory"
			fullpath=$(basename $directory)
			rm -f $directory/mainfeed.$extension
			touch $directory/mainfeed.$extension
		    echo "Downloading files in $(realpath $(dirname $directory/mainfeed.$extension))"
			STATUS=($(curl -I -s -L $url | grep "HTTP/2\|HTTP/1.1" | cut -d' ' -f 2))	
			if [ -z "$limit" ];
			then
				while [[ "$STATUS" -eq "200" ]]; do
					printf "\n$url is being fetched\n"
					printf "\nStatus code: $STATUS\n\n"
					curl  $url > $directory/feed_$counter.$extension
					cat $directory/feed_$counter.$extension >> $directory/mainfeed.$extension		
					counter=$((counter+1))
					url=${url_arg/\{0\}/$counter}
					STATUS=($(curl -I -s -L $url | grep "HTTP/2\|HTTP/1.1" | cut -d' ' -f 2))
				done
			else
				if [ "$limit" -eq "$limit" ] && [ $limit -gt 0 ] && [ "$STATUS" -eq "200" ] 2>/dev/null; then
					while [ $counter -le $limit ] ; do
						printf "\n$url is being fetched\n"
						printf "Status code: $STATUS\n\n"	
						curl  $url > $directory/feed_$counter.$extension
						cat $directory/feed_$counter.$extension >> $directory/mainfeed.$extension		
						counter=$((counter+1))
						url=${url_arg/\{0\}/$counter}
						STATUS=($(curl -I -s -L $url | grep "HTTP/2\|HTTP/1.1" | cut -d' ' -f 2))
					done
				else
					echo "Please pass a positive numeric value as argument "; exit 1
				fi
			fi
			directory=$(echo "/$directory" | sed -e 's/\\/\//g' -e 's/://')
			rm -f $directory/feed_*
			printf "Feed download stopped at URL: $url with status code $STATUS \n"
			printf "Cleaning the directory $directory... "
	fi
else
	printf "\nPlease provide a URL with a multipage macro {0} included\n"
fi