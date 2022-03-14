#!/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: ./cpu.sh <Time In Minutes> <Threshold Vaue>"
   echo "options:"
   echo "Input Time in Minutes: 60(Means 60 Minutes)"
   echo "Input Threshold in Percentage: 5(Means threshold of 5% CPU utilization)"
   echo
}

## Logic where it takes only 2 arguments and if arguments are more than 2 than it will throw error. 
if [ $# -eq 2 ]; then
        timeStamp=$(date +%Y-%m-%d,%T)
        inputTime=$1
        inputThreshold=$2
        input=$((60 * $inputTime))
        CurrentTime=$(date +%s)
        Time1=`date -u -d "0 $CurrentTime sec - $input sec" +"%H:%M:%S"`
        echo "Start time: $Time1"
        echo "End time: $(date +%T)"
        avgCPU_utilisation=`sar -u -s $Time1 -e $(date +%T) | grep Average  | awk '{print 100 - $8}' | tail -n 1`
        echo $avgCPU_utilisation
        if [ "$avgCPU_utilisation -lt $inputThreshold" ]; then
                echo $timeStamp " - " $avgCPU_utilisation "- System is Shutting down">> /tmp/last_average_CPU_Utilization_in_percentage.txt
                /usr/sbin/shutdown -P now
        else
                echo "System will NOT shut down"
                echo $timeStamp " - " $avgCPU_utilisation "- System will NOT Shutdown">> /tmp/last_average_CPU_Utilization_in_percentage.txt

        fi
else
    echo "No arguments supplied"
fi


############################################################
# Main program                                             #
############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

