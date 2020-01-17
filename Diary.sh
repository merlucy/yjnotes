#!/bin/bash

echo -e "Hi, welcome to bashDiaries. \nChoose 1 to Write, 2 to Modify or 3 to Delete"
read action

if [ $action = "1" ]
then

	cp template.txt currentDiary.txt

	vim currentDiary.txt

	title=$(grep -i "title:" currentDiary.txt | sed -n '1 p' | awk 'NR=1 {print $2}')
	echo $title

	originalName=$(ls -lt | sed -n '2 p' | awk 'NR=1 {print $9}')
	echo $originalName

	newName=$(ls -ltT | sed -n '2 p' | awk 'NR==1 {print $9"_"$6"_"$7"_"$8}')
	newName+="_${title}.txt"
	echo $newName

	mv $originalName $newName
elif [ $action = "2" ]
then
	echo "Following is the files currently registered"
	ls -Ut | egrep "^[0-9]{4}" 	
	
	echo "Please choose the file that you want to MODIFY."
	read fileSelection
	
	fileCheck=$(ls -tU | grep $fileSelection | head -n 1)

	if [ -n $fileCheck ]
	then
		vim $fileCheck
	else
		echo "Notthing"
	fi

else
	echo "Following is the files currently registered"
	ls -Ut | egrep "^[0-9]{4}" 	
	
	echo "Please choose the file that you want to DELETE."
	read fileSelection
	
	fileCheck=$(ls -tU | grep $fileSelection | head -n 1)

	if [ -n $fileCheck ]
	then
		rm $fileCheck
	else
		echo "Notthing"
	fi
fi
