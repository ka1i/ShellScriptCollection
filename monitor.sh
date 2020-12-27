#!/bin/bash

# Copyright © Mardan . All Rights Reserved.
:<<Comments 代码说明
这是一个用户监测程序monitor, 
其运行格式为：monitor username
其中username是用户指定的任意一个用户名。
程序运行时首先列出当前系统中的已登录用户的名单，再检查指定用户是否已登录。
如果已登录，则显示相应信息；如果未登录，则等待该用户登录，直到指定用户登录进入系统为止。
Comments

trap "echo -e '\n\033[?25hByeBye!';exit" 2
#定义全局变量
STATUS=0
LINE=5

#判断命令行参数，并输出用法
if [[ $# != 1 ]];then
		echo "Usage:"
		echo "  $0 username"
		exit 1
fi

while true; do
		#在用户列表中过滤要查询的用户，不存在返回空
		get_result=`who |awk '{print $1}'|grep $1`
		#如果用户搜索的用户不在，则等待登录
		if [[ -z "${get_result}" ]];then
				STATUS=1
				echo -ne "\033[?25lWating User: $1 login"
				sleep 1
				echo -ne " > "
				sleep 1
				echo -ne "> "
				sleep 1
				echo -ne ">"
				sleep 1
				echo -ne "\033[52D\033[K\033[?25h"
		else
		#用户存在，则显示详细信息
				if [ ${STATUS} -eq 0 ];then
						echo "user $1 is login"
						exit 0
				else
						echo "$1 is log on"
						exit 0
				fi
		fi
done