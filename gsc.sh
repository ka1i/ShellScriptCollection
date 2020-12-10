#!/bin/bash --posix

# Auther Mardan
# git sparse checkout 脚本化
## 此脚本 拉取仓库主分支，就算url带`/tree/devlep`等分支选择，所以注意。
## git版本 至少2.25
# Usage: gsc.sh file-url


url=$1
if [[ ! -n $url ]];then
	echo "Usage: gsc repo-url"
	echo "Ensure git minimum version is 2.25"
	exit -1
fi
gitVersion="$(git --version)"
if [[ "$gitVersion" =~ "git version" ]]; then
    echo "Local $gitVersion"
  else
    eixt -1
fi

if [[ "$(echo $url | awk -F'[/]' '{print $1}')" == "https:" ]]; then
	repoUrl="https://github.com/"
else
	echo "Plz use https"
	exit -1
fi
owner=$(echo $url | awk -F'[/]' '{print $4}')
repository=$(echo $url | awk -F'[/]' '{print $5}')
resFlags=${repository}
echo "Repository: ${repoUrl}${owner}/${repository}"
if [[ "$(echo $url | awk -F'[/]' '{print $6}')" == "tree" ]]; then
	resFlags="tree/*/"
fi
floderPath=${url#*$resFlags}
floder=$(echo $url | awk -F'[/]' '{print $NF}')
echo "Checkout: $floderPath >>> $floder"
git clone --filter=blob:none --no-checkout "${repoUrl}${owner}/${repository}" "${repository}_${floder}"
cd "${repository}_${floder}"
git sparse-checkout init
git sparse-checkout set ${floderPath}
echo "Check list: >>>"
git sparse-checkout list
git checkout
exit 0