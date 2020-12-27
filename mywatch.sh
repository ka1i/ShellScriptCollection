#!/bin/bash

# Copyright © Mardan . All Rights Reserved.
:<<Comments 代码说明
此SHELL程序，可以动态检测指定文件的状态信息，当文件的大小发生改变时，给出提示信息，并继续进行检测。
Comments

#定义全局变量
FILE_SIZE=0
WHILECOUNT=0
CHANGESIZECOUNT=0
FILE_NAME=""

clear
if [[ $# != 1 ]];then
    echo -n "Please enter the filename: "
    read FILE_NAME
else
    FILE_NAME=$1
fi

if [ -e "${FILE_NAME}" ];then
    ls -l ${FILE_NAME}
    FILE_SIZE=`ls -l ${FILE_NAME} |awk '{print $5}'`
    while true;do
        #累计计数文件改变状态
        if [ $FILE_SIZE != `ls -l $FILE_NAME |awk '{print $5}'` ];then
            echo "file [ $FILE_NAME ] size changed"
            FILE_SIZE=`ls -l ${FILE_NAME} |awk '{print $5}'`
            let CHANGESIZECOUNT+=1
            WHILECOUNT=0
        else
            let WHILECOUNT+=1
            fi
            #当被检测的文件或者已累计改变了两次大小
            if [ "$CHANGESIZECOUNT" = "2" ];then echo "file $FILE_NAME has been changed twice";exit 0 ;fi
            #已连续被检测了十次还未改变大小时
            if [ "$WHILECOUNT" = "10" ];then echo "file $FILE_NAME has not changed";exit 0;fi
            sleep 3
    done
else
        #文件不存在
    echo "Sorry,the file $FILE_NAME does not esist"
fi