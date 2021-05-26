#!/bin/bash
#grep for negative amounts in player data files, 
#add the 4-digit date to a single file and clean up any 8-space instances to tab delimiters
grep -F '-' ????_win_loss_player_data |sed s/_win_loss_player_data:/'\t'/|sed s/'        '/'\t'/ >Roulette_Losses
