#!/bin/bash
count=1
Max=5
while [ $SECONDS -le $Max ]
do
echo "This is $count time to run!"
let count=count+1
sleep 2
done
echo "The time of the scripts to run is $SECONDS."
