# Scenario2

## Overview 

Please create cron job in Linux, which will check average CPU utilization in the system (average
of 1 hour) and if avg CPU utilization will be below the given threshold then will shut down the
whole instance.
Requirements:
1. Cronjob should run a previously written bash script and this bash script should check
average CPU utilization
2. Bash script as input should take 2 arguments:
  1. time in minutes to consider average CPU utilization, e.g. 60 (means an average CPU utilization of last 60 minutes), 120 (means an average CPU utilization of last 120 minutes)
  2. the threshold in percentage, that below that threshold system should shut down     itself, e.g. 5 (means threshold of 5% CPU utilization)
3. Cronjob should run previously written bash script every minute (* * * * *)
4. Please create a log file, that will contain timestamp and the last average CPU Utilization
in percentage

<!--- BEGIN_TF_DOCS --->

## Requirements
1. sysstat must be installed on server.
2. As we need to calculate history of Load Avg so we need the data to calculate it. I am using sar for this task. 
2. Therefor it is required that server must have old data or must be running for atleast 3 - 4 hours minimum continously so that sar can generate report. 
3. Cronjob can be entered by root or any user. If user is being ued then please use sudo. 


## Implementation:
1. Setting up a cron entry by root
2. Created bash script where Logic it takes only 2 arguments and if arguments are more than 2 than it will throw error.
3. avgCPUCheck.sh will take 2 arguments and on bases of output of average CPU utilization and threshold
4. If the value is below then given threshold the system will should Shutdown otherwise it will redirect the average CPU utilization value to "/tmp/last_average_CPU_Utilization_in_percentage.txt" with timestamps. 
5. Cronjob will be running every minute. This
6. We are assuming following are the input values, which can be modified accordingly. 
   1. Input Time in Minutes: 60(Means 60 Minutes)
   2. Input Threshold in Percentage: 5(Means threshold of 5% CPU utilization)
7. We will be running script in background. We are redirecting the script’s output to an empty location, like /dev/null which immediately deletes any data written to it.

## Steps:

1. Almost every Linux distribution has some form of cron installed by default. However, if you’re using an Ubuntu/Centos machine on which cron isn’t installed, you can install it using APT/YUM. Before installing cron on an Ubuntu/Centos machine, update the computer’s local package index:
```
$ sudo apt update # Ubuntu/Debian System
$ sudo yum update # Centos/rhel System
```

Then install cron with the following command:
```
$ sudo apt install -y cron # Ubuntu/Debian System
$ sudo yum install -y cron # Centos/rhel System
```

You’ll need to make sure it’s set to run in the background too:
```
$ sudo systemctl enable cron
```
Edit crontab with the following command and Add below line and save and out
```
$ sudo crontab -e
* * * * *   /root/avgCPUCheck.sh 60 5 > /dev/null 2>&1
```

If you’d like to view the contents of your crontab, but not edit it, you can use the following command:
```
$ sudo crontab -l
```

## Author
Mayank Koli