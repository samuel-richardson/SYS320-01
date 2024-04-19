#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function courseLocation(){
echo -n "Input the course location: "
read location
echo "Courses at $location"
cat "$courseFile" | grep "$location" | cut -d";" -f 1,2,5,6,7 | sed 's/;/ | /g'
echo ""

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function courseAvail() {

echo -n "Enter course code: "
read code

cat $courseFile | grep -E "^$code" > coursesbycode.txt

echo "Availible courses"

while read line
do

seats=$( echo $line | cut -d";" -f 4 )

[ 0 -lt $seats ] && echo $line | sed 's/;/ | /g'

done < coursesbycode.txt

}


while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display course by location"
	echo "[4] Display availible courses"
	echo "[5] Exit"

	read userInput
	echo ""
	isValid=$(echo $userInput | grep -E -v '^[1-5]{1}$')

	[ $isValid ] && echo "Not a valid input. Enter a number 1 thorugh 5." && continue 


	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts
	elif [[ "$userInput" == "3" ]]; then
		courseLocation
	elif [[ "$userInput" == "4" ]]; then
		courseAvail

	# TODO - 3 Display a message, if an invalid input is given
	fi
done

