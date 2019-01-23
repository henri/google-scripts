##!/usr/bin/env bash

# Add on the headers to a CSV file for bulk upload to Google Apps.
# Copyright Henri Shustak 2013
# Released under the GNU GPL

input_file="${1}"
backup_file="${input_file}.backup"
temporary_file="${input_file}.temporary"

# make a backup of the file
cp "${input_file}" "${backup_file}"
if [ $? != 0 ] ; then
    echo "ERROR! : Unable to generate backup file."
    exit -1
fi

# add the lines to a temporary file (this will also overwrite any old temporary file which may exist)
echo "\"email address\",\"first name\",\"last name\",\"password\"" > "${temporary_file}"
if [ $? != 0 ] ; then
    echo "ERROR! : Unable to temporary file with headers."
    exit -1
fi

# append the input file to the temporary file
cat "${input_file}" >> "${temporary_file}"
if [ $? != 0 ] ; then
    echo "ERROR! : Unable to append the temporary file with data."
    exit -1
fi

# remove the input file and rename the temporary file.
rm "${input_file}"
if [ $? != 0 ] ; then
    echo "ERROR! : Unable to remove the input file."
    exit -1
fi

# move the input file from being a temporary file to the output file (changing .tab to .csv)
output_file=${input_file%.tab}.csv
mv -i "${temporary_file}" "${output_file}"
if [ $? != 0 ] ; then
    echo "ERROR! : Unable to rename the temporary file to be the same as the input file."
    exit -1
fi



echo "Done."
echo "Remember - (1) After uploading to move the user(s) to the apprpriate orgonization."
echo "         - (2) Add user(s) to approriate mailing list groups."

exit 0 

