#!/bin/bash
####   使用方法:把要跟踪的地址写入ip.txt,程序会把每个ip走的出口写入out文件。
####   mtracepoint.sh
####   举例:bash mtracepoint.sh
host=ip.txt
number=`cat ${host}|wc -l`
for ((i=1;i<=$number;i++))
do
        Host=`head -$i ${host}|tail -1`
        echo ${Host}
        traceroute -m4 ${Host} | awk -F" " -v Host=$Host '$0~/10.223.[1-9][0-9][0-9].2\>/{print Host," ",$3 >> "out"}' &
done
wait
