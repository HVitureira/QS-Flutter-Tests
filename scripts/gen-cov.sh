#!/usr/bin/bash 

echo Test Coverage Report Start 

CWD="$(pwd)/coverage/lcov.info"
#echo $CWD 
flutter test --coverage 

sed -i 's/\\/\//gI' $CWD 

echo Generating Html Report

wsl lcov --remove coverage/lcov.info '**/models/*.dart' -o coverage/lcov.info

wsl genhtml coverage/lcov.info  -o coverage/html/

start coverage/html/index.html

echo Generating Html Report Ended