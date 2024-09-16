#!/bin/bash
#one-liner-magic generated using ChatGPT4o
cp resume.json resume.json.old
LIST=`find ~/Seafile/MyLibrary/Service/Reviews -depth 1 -type d ! -name '_*' | awk -F/ '{print $NF}' | sort -f | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/, /g'`
echo ${LIST}
sed "s/<ADD_HERE>/\t\t\"summary\": \"${LIST}\"/g" resume-addhere.json > resume-checkmeout.json 

#sed "s/<ADD_HERE>/\t\t\"summary\": \"`find ~/Seafile/MyLibrary/Service/Reviews -depth 1 -type d ! -name '_*' | awk -F/ '{print $NF}' | sort -f | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/, /g'`\"/g" resume-addhere.json > resume.json 
