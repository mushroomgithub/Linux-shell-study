#!/bin/bash
i=0
 until [[ "$i" -gt 5 ]]
 do
	let "square=i*i"
  	echo "$i*$i=$square"
        let "i++"
 done

