#!/bin/bash
#Outputs the first name and surname of the dealer working at the specified date and time on the roulette table.
grep -F ':' $1_Dealer_schedule|grep $2 | grep $3| awk -F'\t' '{print $1,$3}' |awk -F' ' '{print $3,$4}'
