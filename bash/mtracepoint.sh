#!/bin/bash
####   使用方法:把要跟踪的地址写入ip.txt
####   mtracepoint.sh 出口
####   举例:bash mtracepoint.sh 10.223.126.2

host=ip.txt
number=`cat ${host}|wc -l`
if [ -n $1 ]
then
	mt=$1
else
	mt="10.223.120.2"
fi
for ((i=1;i<=$number;i++))
do
        Host=`head -$i ${host}|tail -1`
        echo ${Host}
        if traceroute ${Host} | grep -q ${mt} ;then
            nali ${Host} >> ${mt}.txt
        fi &
done
wait
