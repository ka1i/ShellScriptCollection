#!/bin/bash

# Copyright © Mardan . All Rights Reserved.
:<<Comments 代码说明
此SHELL程序，将用户从键盘输入的文本附加到一个指定的文件中。如果该文件不存在，则新建立该文件；如果该文件已经存在，则把键盘输入的文本附加到该文件后面。输入内容及行数不限定，以空行表示输入结束。运行结束时显示该文件内容。
Comments

#定义全局变量
INPUT="null"

#判断命令行参数，并输出用法
if [ $# != 1 ];then
        echo "Usage: $0 filename"
        exit 1
fi
#判断文件是否存在，不存在则创建文件
if [ ! -d $1 ];then
        touch $1
fi
#开始获取用户文本
while true;do
    echo -en "\033[35mPlease input text:\033[0m"
    read -r INPUT
    echo ${INPUT}
    #判断输入是否结束
    if [ -z "${INPUT}" ];then
        echo -e "file $1 \n\t*** START ***"
        cat $1
        echo -e "\t*** ENDING ***"
        echo -n "file $1 Read and Write protection mode: " ;ls -lh $1 |awk '{print $1}'
        exit 0
    fi
        #未结束写入内容
        echo ${INPUT}>>$1
done