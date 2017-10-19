#!/bin/bash
usage="Usage ${0} [ branch ( default is master ) ]"
# 初始步数
i=0;
# 如果.env文件不存在，拷贝.env.example
if [ ! -f ".env" ]; then
    echo "$((i++)): 拷贝生成.env配置文件"
    cp .env.example .env
fi
# 修改文件权限
# echo "$((i++)): 除 当前执行脚本文件$(basename ${0}) .git vendor node_modules storage文件夹外当前目录下的所有文件权限修改为644";
# sudo find . \( -path ./storage -o -path ./.git -o -path ./vendor -o -path ./node_modules \)  -prune -o  ! -name $(basename ${0}) -type f  -exec chmod 644 {} \;
echo "$((i++)): 除.git vendor node_modules storage文件夹外当前目录下的所有文件权限修改为644";
find . \( -path ./storage -o -path ./.git -o -path ./vendor -o -path ./node_modules \)  -prune -type f  -exec chmod 644 {} \;
# 修改文件夹权限
echo "$((i++)): 除 .git vendor node_modules storage文件夹外当前目录下的所有文件夹权限修改为755";
find . \( -path ./storage -o -path ./.git -o -path ./vendor -o -path ./node_modules \)  -prune -o -type d -exec chmod 755 {} \;
# 删除storage缓存和日志、session
#echo "$((i++)): 删除storage缓存、session等";
#for file in ./storage/framework/*
#do
#  if test -d $file
#  then
#    sudo find $file ! -name ".gitignore" -type f -exec rm -rf {} \;
#  fi
#done
#echo "$((i++)): 删除项目日志";
# 删除项目日志
#sudo rm -rf ./storage/logs/*.log;
# 修改stroage目录权限
echo "$((i++)): storage下文件夹权限为777";
find ./storage/ -type d -exec chmod 777 {} \;
echo "$((i++)): storage下文件权限为666";
find ./storage/ -type f -exec chmod 666 {} \;
echo "$((i++)): storage下秘钥文件权限为644";
# oauth秘钥权限
find ./storage/ -type f -name "*.key" -exec chmod 644 {} \;
# 修改bootstrap/cache目录权限
#chmod 777 ./bootstrap/cache
#echo "$((i++)): bootstrap/cache文件夹权限为777";
# 如果storage软链接不存在
#if [ ! -L "./public/storage" ]; then
#    echo "$((i++)): 生成storage软链接"
#    php artisan storage:link
#fi
# 重新生成APP_KEY
# sudo -u www php artisan key:generate
# 安装更新npm第三方插件
# echo "$((i++)): 安装npm第三方插件";
# yarn install
# 安装php composer第三方插件
echo "$((i++)): 安装composer第三方插件";
composer install

