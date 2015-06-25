#!/bin/bash
####   使用方法:把要跟踪的地址写入ip.txt,程序会把每个ip走的出口写入out文件。
####   举例:bash mtracepoint.sh
host=ip.txt
number=`cat ${host}|wc -l`
for ((i=1;i<=$number;i++))
do
        Host=`head -$i ${host}|tail -1`
        echo ${Host}
	Zone=`nali ${Host}`
	echo ${Zone}
#跟踪4跳路由就停止，然后，在路由中搜索10.223.*.2出口，以及10.223.227.121互联，并所属的ip以及搜索到的所走的出口写入out文件。
	traceroute -m4 ${Host} | awk -F" |(|)" -v Host=$Host '$0~/10.223.[1-9][0-9][0-9].2\>|10.223.227.121/{print Host,$4 >> "out"}' &
#	traceroute -m4 ${Host} | awk -F" |(|)" -v Host=$Host '{if(match($0,/10.223.[1-9][0-9][0-9].2\>|10.223.227.121/))print Host,$4 >> "out"}' &
#	traceroute -m4 ${Host} | egrep -o /10.223.[1-9][0-9][0-9].2\>|10.223.227.121/ &
done
wait
