#!/bin/bash

#Start of script execution counter
start=`date +%s`

#Downloadd all index pages using wget and rename them with the website name

for i in https://www.capital.bg \
	https://www.linuxacademy.com \
	https://www.gmail.com \
	https://www.abv.bg \
	https://www.dir.bg \
	https://www.youtube.com \
	https://www.github.com \
	https://www.linux.org \
	https://www.wikipedia.com \
	https://www.kubernetes.io;

do echo $i | wget -O $(gawk -F"//" '{print $2}') $i;
done
#Check if all websites are downloaded

indexcounter=$(ls www* | wc -l)
if [ $indexcounter -lt 10 ]; then
	echo "Less than 10 index pages downloaded!"
else
	echo "----------------------------------"
	echo ""
	echo "All 10 index pages saved!"
	echo ""
fi

#Create text file with index files names

ls -al www* | gawk '{print $9}' > indexlist.txt

#Use the indexlist.txt to count href lines and create files with this lines only

input="indexlist.txt"
while IFS= read -r line
do
	  echo "$line contain $(cat $line | grep "href=" | wc -l) "href=" lines"
	    echo "Creating file with only href ilnes in it >>>>>>>> hrefonly.$line"
	      echo ""
	        cat $line | grep "href=" > hrefonly.$line
	done < "$input"
	echo "----------------------------------"
	echo ""

	sleep 1

	echo ""
	echo "Removing hrefonly files."

	rm hrefonly*

	echo ""
	echo "All hrefonly files are now removed."
	echo "----------------------------------"

	#Removing indexlist.txt
	rm indexlist.txt

	#Stop of script execution counter
end=`date +%s`

echo ""
echo "It takes $((end-start)) seconds to execute the script!"
