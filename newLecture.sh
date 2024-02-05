#!/bin/bash

# Check if 2 args are given and if the folder already exist
if [[ "$#" -eq 2 ]]; then
if [[ ! -d "lecture$1" ]]; then
# Create the folder, add conv.sh and open main file in nano
mkdir lecture$1;
cp ./conv.sh ./lecture$1;
cd lecture$1;
nano $2.s;
else
echo "lecture$1 already exists."
fi
else
echo "Usage: source $0 lectureNumber lectureName"
echo "Output: a directoy lecture[lectureNumber] containing [conv.sh, lectureName.s]"
echo "This script open the nano text editor for you."
fi


