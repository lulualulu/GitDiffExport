#!/bin/bash
echo "Export Git Diff"

read -p "Export Start Commit ID: " input1
read -p "Export End Commit ID: " input2

commitIdStart="${input1}"
if [ "${input2}" == "" ]; then
	commitIdEnd="HEAD"
else
	commitIdEnd="${input2}"
fi

echo "Start ID: $commitIdStart"
echo "End ID: $commitIdEnd"

#Create Export Folder
now=$(date +%Y%m%d_%H%M%S)
#echo "Current date: $now"
dirpath="GitExport/$now"
echo "Export Path:$dirpath"
mkdir -p $dirpath


#Get File List
files=$(git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT $commitIdStart $commitIdEnd);
#echo $files;

for item in $files ; do
    echo "Copy: $item"
	# For Linux (Todo Test)
	# cp --parents "$item" "$dirpath/$item"
	# For Mac OS
	 ditto "$item" "$dirpath/$item"
done

read -p "Press enter to exit"