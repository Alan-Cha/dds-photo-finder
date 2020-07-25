#!/bin/bash

# Photo types
PHOTO_TYPES=("Capture" "capture" "Select" "select" "Edit" "edit" "Final" "final")

# Checks if the provided path is a photo type path (i.e. it is a photo that 
# should be opened)
# 
# $1 -> provided path
function isPhotoTypePath() {
  for i in "${PHOTO_TYPES[@]}"
  do
    # Check if the provided path contains a photo type
    if [[ "$1" =~ .*"$i".* ]]
    then
      true
      return
    fi
  done

  false
}

# Given a provided path, identify the photo type that the path is associated 
# with
# 
# $1 -> provided path
# 
# photoType -> identified photo type
function whichPhotoType() {
  for i in "${PHOTO_TYPES[@]}"
  do
    if [[ "$1" =~ .*"$i".* ]]
    then
      photoType=$i
      return
    fi
  done

  echo "Could not identify photo type from path"
  exit 1
}

# Handle options
while getopts ":h" opt; do
  case ${opt} in
    h ) # process option h
      echo "Usage:"
      echo "    find-photos [-h] <photo file path in /Volumes>"
      echo
      echo "On a Mac:

Assuming you have a file open in Preview and you would like to open the related files. 

First, go to the top of Preview, command + click the file path, click on the folder, which will bring up the folder in Finder. 

In Finder, right click the file, hold option, click \"Copy \"...\" as Pathname\", which will copy the file path into your clipboard.

Run the program which will open up the related files:

./find-photos.sh <FILE PATH>

Then you can command + click the file path of the Preview windows, click on the folders, then import them into Photos. "
      exit 0
      ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

# Remove options that have been handled by getOpts
shift $((OPTIND -1))

# Check if a photo file path is provided
if [ $# -eq 0 ]
then
  echo "No photo file path provided"
  exit 1
fi

providedPath=$1

# Check if the provided path is a photo type path
if ! isPhotoTypePath "$providedPath"
then
  echo "Please provide a path that contains: \"Capture\", \"Select\", \"Edit\", or \"Final\""
  exit 1
fi

whichPhotoType "$providedPath"

# Extract the folder path that contains the photo type folders
# i.e. /Volumes/photo-album1/Captured/my-photo1.jpg -> /Volumes/photo-album1/
folderPath=${providedPath%$photoType*}
fileName=${providedPath#*$photoType/}

# Source: https://www.unix.com/shell-programming-and-scripting/206765-how-select-first-two-directory-path-name.html
volumeName=$(echo "$providedPath" | sed -n 's:^\(/[^/]\{1,\}/[^/]\{1,\}\).*:\1:p')

# Loop through matching file name in /Volumes
find "$volumeName" -name "$fileName" -print0 | while read -d $'\0' file
# find /Volumes -name $1 | while read file
do
  # find may provide invalid paths
  if ! [[ $file =~ "find:".* || $file =~ .*"Operation not permitted" ]]
  then
    # Open files that have the same beginning folder path
    # Photo files may have the same name (which is often a sequential ID)
    if [[ $file =~ "$folderPath".* ]]
    then
      echo opening "$file"
      open "$file"
    fi
  fi
done

# ===== Extraneous code =====

# # Given a check function and an array, identify the array index such that 
# # the check function returns true
# # 
# # $1 -> check function
# # $@ -> array
# function whichArrayIndex() {
#   result=-1

#   # Extract check function and array
#   f=$1
#   shift
#   arr=("$@")

#   # Loop through array
#   for i in "${arr[@]}";
#   do
#     # Run check function on element
#     if [[ $f $i ]]
#     then
#       result=$i
#     fi
#   done

#   echo $result
# }