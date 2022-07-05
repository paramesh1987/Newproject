#!/bin/bash
nohup /usr/local/tomcat/bin/startup.sh &
echo "executing the notify process now.."
src=$WEBAPPS_STAGING
dest=/usr/local/tomcat/webapps/
cd $src
while :
do
    declare -A fileStamps
    for fileName in $src/*.war; do
        fileStamps[$fileName]=$(date -r $fileName +%s)
    done
    sleep 12
    for index in "${!fileStamps[@]}"
    do
        lastM=${fileStamps[$index]}
        newM=$(date -r $index +%s)
        if [ $newM -gt $lastM ];then
            echo "$index updated- will copy to tomcat now.."
            yes | cp -rf $index $dest
        fi
    done
done