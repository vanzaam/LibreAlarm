#!/bin/bash
# usage: ./calcSuperISF.sh maxDropRate5Min basalAverageHourly normalISF deltaBGFromTarget
maxDropRate5Min=$1
basalAverageHourly=$2
normalISF=$3
deltaBGFromTarget=$4    # this gets cancelled out of the final result
#
if [ $(bc <<< "$maxDropRate5Min < 0") -eq 1 ]
then
   maxDropRate5Min=$(bc <<< "scale=4; -$maxDropRate5Min")
fi
basalMinutesSteal=$(bc <<< "scale=4; ($deltaBGFromTarget/($maxDropRate5Min/5.0))")
stolenUnits=$(bc <<< "scale=4; ($basalMinutesSteal/60.0)*$basalAverageHourly")
regularUnits=$(bc <<< "scale=4; $deltaBGFromTarget/$normalISF")
totalUnits=$(bc <<< "scale=4; $regularUnits+$stolenUnits")
superISF=$(bc <<< "scale=2; $deltaBGFromTarget/$totalUnits")
echo "superISF=$superISF"