#!/bin/bash
grep -F ':' $1_Dealer_schedule|grep $2 | grep $3| awk -F'\t' '{print $1,$3}' |awk -F' ' '{print $1,$2,$3,$4}'
