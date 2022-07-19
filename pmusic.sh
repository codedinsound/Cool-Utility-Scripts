#!/bin/bash
# Author: Luis Santander

DIRECTORY_PATH=/Users/$USER/Downloads

clear
echo "Running Music Pre-Processor converting mp3 and wav ----> aiff"

if [ "$1" = "-c" ] || [ "$1" = "-current" ]
then
	DIRECTORY_PATH=$(pwd)
	echo $1
fi 

# MARK:  Test if Music Files Exist
testMP3=`ls -1 $DIRECTORY_PATH/*.mp3 2>/dev/null | wc -l`
testWAV=`ls -1 $DIRECTORY_PATH/*.wav 2>/dev/null | wc -l`

# # Capitilize WAV Files if found and convert to AIFF
if [ $testWAV != 0 ]
then
	echo "1: ${testWAV} WAV Files Found"
	rename -f 's/.+(?=\.)/\U$&/g' $DIRECTORY_PATH/*.wav

	# Convert it to AIF
	for FILE in $DIRECTORY_PATH/*.wav
	do
		ffmpeg -i "${FILE}" "${FILE%.*}.aiff"
		sleep 2 
	done

	sleep 5 
	echo "2: Removing .wav copies......."
	rm $DIRECTORY_PATH/*.wav
	sleep 5 
fi

# Capitalize mp3 files if found and convert to AIFF
if [ $testMP3 != 0 ]
then
	echo "1: ${testMP3} MP3 Files Found"
	rename -f 's/.+(?=\.)/\U$&/g' $DIRECTORY_PATH/*.mp3

	# Convert it to AIF
	for FILE in $DIRECTORY_PATH/*.mp3
	do
		ffmpeg -i "${FILE}" "${FILE%.*}.aiff"
		sleep 2 
	done

	sleep 5 

	echo "2: Removing .mp3 copies......."
	rm $DIRECTORY_PATH/*.mp3

	sleep 5 
fi

testAIFF=`ls -1 $DIRECTORY_PATH/*.aiff 2>/dev/null | wc -l`

if [ $testAIFF != 0 ]
then
	rename -f 's/.+(?=\.)/\U$&/g' $DIRECTORY_PATH/*.aiff
	sleep 1
	echo "3: Creating processed directory and moving all aiff files into it."
	mkdir "$DIRECTORY_PATH/processed"
	mv $DIRECTORY_PATH/*.aiff "$DIRECTORY_PATH/processed"
fi 
