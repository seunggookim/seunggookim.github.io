#!/bin/bash
#one-liner-magic generated using ChatGPT4o

# # create a backup file:
# sed 's/"basics"/"_basics"/g' resume.json > backup.json # not to confuse the remote builder
cp resume.json backup.json

# create a string to add:
LIST=`find ~/Seafile/MyLibrary/Service/Reviews -depth 1 -type d ! -name '_*' | awk -F/ '{print $NF}' | sort -f | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/, /g'`
echo ${LIST}

# add the string:
sed "s/\"<ADD_HERE>\": \"\"/\"summary\": \"${LIST}\"/g" addhere.json > resume.json 

#sed "s/<ADD_HERE>/\t\t\"summary\": \"`find ~/Seafile/MyLibrary/Service/Reviews -depth 1 -type d ! -name '_*' | awk -F/ '{print $NF}' | sort -f | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/, /g'`\"/g" addhere.json > resume.json 
