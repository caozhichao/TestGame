#!/bin/sh
insert=0
delete=0
git log --author=$1 --shortstat --pretty=format:""|sed /^$/d > .tmp.count

while read line ;do
current=`echo $line|awk -F ',' '{printf $2}'|awk '{printf $1}'`
insert=`expr $insert + $current`
current=`echo $line|awk -F ',' '{printf $3}'|awk '{printf $1}'`
delete=`expr $delete + $current`
done <.tmp.count
echo $1 $insert insertions, $delete deletions

