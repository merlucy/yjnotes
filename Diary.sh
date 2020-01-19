#!/bin/bash

echo -e "Hi, welcome to bashDiaries. \nChoose 1 to Write, 2 to Modify or 3 to Delete"
read action

#If $action equals 1, then the diary creates a new entry.
if [ $action = "1" ]
then

	cp template.txt currentDiary.txt
	vim currentDiary.txt

	#Fetch the title from the saved file, and stores it in $title.
	#sed first removes the Title: tag, and removes possible blank at the very
	#beginning of the line.
	#tr replaces blanks with the underscore.
	title=$(grep -i "title:" currentDiary.txt | sed -e 's/Title://g' | sed 's/^[ ]//' | tr ' ' _)
	echo $title

	#Stores the temporarily created file's name
	originalName=$(ls -lt | sed -n '2 p' | awk 'NR=1 {print $9}')
	echo $originalName

	#Replaces the temporarily created file's name with the new time and title
	#information.
	newName=$(ls -ltT | sed -n '2 p' | awk 'NR==1 {print $9"_"$6"_"$7"_"$8}')
	newName+="_${title}.txt"
	
	echo $newName

	#Changes the name of the file
	mv $originalName $newName

#If $action equals 2, then the diary modifies an already existing entry.
elif [ $action = "2" ]
then
	#The following lines of code lists the currently saved entries.
	echo "Following is the files currently registered"
	ls -Ut | egrep "^[0-9]{4}" 	
	
	#Takes in user input to choose the file to modify.
	echo "Please choose the file that you want to MODIFY."
	read fileSelection

	#Checks if the desired file is in the list of entries.	
	fileCheck=$(ls -tU | grep $fileSelection | head -n 1)

	#If there is a file with the desired name, it opens the file for modification.
	#If condition checks if the variable, which stores the result of the search,
	#is empty.
	if [ ! -z "$fileCheck" ]
	then
		echo $fileCheck
		vim $fileCheck
	else
		echo "We could not find the file you were requesting"
	fi

#If $action is 3, then the diary deletes an already existing entry.
elif [ $action = "3" ]
then
	#Shows the list of current entries
	echo "Following is the files currently registered"
	ls -Ut | egrep "^[0-9]{4}" 	
	
	#Asks for user input
	echo "Please choose the file that you want to DELETE."
	read fileSelection
	
	#Stores the result of the file search into variable fileCheck
	fileCheck=$(ls -tU | grep $fileSelection | head -n 1)

	if [ ! -z $fileCheck ]
	then
		echo "We have found the following file:"
		echo $fileCheck
	
		#Asks if the user would like to delete the file.
		echo -e "\nIf you want to delete the file type yes"
		read yon
		
		if [ "$yon" = "yes" ] 
		then
			rm $fileCheck
			echo "You have deleted the file"
		else
			echo $yon
			echo "You chose not to delete the file"
		fi
	else
		#If the file the user entered could not be found, terminate the program
		echo "We could not find the file you were requesting"
	fi

else
	echo "You have selected an action that does not exist"
	echo "The program will terminate. Thank You."
fi
