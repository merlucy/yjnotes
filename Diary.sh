#!/bin/bash

echo "Hi, welcome to bashDiaries. Which action do you want to take? Write, Modify or Delete?"
read action

if [ $action = "Write" ]
then

	cp template.txt currentDiary.txt

	vim currentDiary.txt

	title=$(grep -i "title:" currentDiary.txt | sed -n '1 p' | awk 'NR=1 {print $2}')
	echo $title

	originalName=$(ls -lt | sed -n '2 p' | awk 'NR=1 {print $9}')
	echo $originalName

	newName=$(ls -lt | sed -n '2 p' | awk 'NR==1 {print $6"_"$7"_"$8}')
	newName+="_${title}.sh"
	echo $newName

	mv $originalName $newName
elif [ $action = "Modify" ]
then
		
	echo "Nothing!"
fi
