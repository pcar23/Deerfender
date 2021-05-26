#!/bin/bash
#Syntax is  roulette_dealer_finder_by_time_and_game.sh [date] [Time] [AM/PM] [GAME TYPE]
if [ $1 = "-h" ];
  then
    echo "Syntax is  roulette_dealer_finder_by_time_and_game.sh [date] [Time] [AM/PM] [GAME TYPE]"
    echo "Valid game types are:"
    echo "B : BlackJack"
    echo "R : Roulette"
    echo "T : TexasHoldEm"
    echo ""
    echo "example use: roulette_dealer_finder_by_time_and_game.sh 0310 05:00 AM B"
    exit 1
fi
if [ $4 = "B" ];
  then
    grep -F ':' $1_Dealer_schedule|grep $2 | grep $3| awk -F'\t' '{print $1,$2}' |awk -F' ' '{print $3,$4}'
fi
if [ $4 = "R" ];
  then
    grep -F ':' $1_Dealer_schedule|grep $2 | grep $3| awk -F'\t' '{print $1,$3}' |awk -F' ' '{print $3,$4}'
fi
if [ $4 = "T" ];
  then
    grep -F ':' $1_Dealer_schedule|grep $2 | grep $3| awk -F'\t' '{print $1,$4}' |awk -F' ' '{print $3,$4}'
fi

