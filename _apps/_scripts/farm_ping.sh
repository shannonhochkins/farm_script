#! /bin/bash
#$ -N $1
# Comma deliminate options [IP ADDRESS, HOSTNAME, FARM GROUP]

## To update a single node, you can use the system shell command like so: 
## 
## sh /mnt/raid/farm_script/_apps/_scripts/farm_ping.sh 1.110,Node-001,Farm
## 
## So we've just updated Node 01 by it self.
##
## Login to the server via ssh
## ssh limeworks@server
## password: lime77
## This file is being called, recurrsively via a cronjob on the server, use "env EDITOR=nano crontab -e" to view the cron jobs on the server
## Here you can edit the time function of the job.

hosts=(NODE IPS)
hosts[0]="1.110,Node-01,Farm"
hosts[1]="1.111,Node-02,Farm"
hosts[2]="1.112,Node-03,Farm"
hosts[3]="1.113,Node-04,Farm"
hosts[4]="1.114,Node-05,Farm"
hosts[5]="1.115,Node-06,Farm"
hosts[6]="1.116,Node-07,Farm"
hosts[7]="1.117,Node-08,Farm"
hosts[8]="1.118,Node-09,Farm"
hosts[9]="1.119,Node-10,Farm"
hosts[10]="1.120,Node-11,Farm"
hosts[11]="1.121,Node-12,Farm"
hosts[12]="1.122,Node-13,Farm"
hosts[13]="1.123,Node-14,Farm"
hosts[14]="1.124,Node-15,Farm"
hosts[15]="1.125,Node-16,Farm"
hosts[16]="1.126,Node-17,Farm"
hosts[17]="1.127,Node-18,Farm"
hosts[18]="1.128,Node-19,Farm"
hosts[19]="1.129,Node-20,Farm"
hosts[20]="1.231,Nerd-01-Crystal,Staff"
hosts[21]="1.243,Nerd-02-Lachlan,Staff"
hosts[22]="1.241,Nerd-03-Jen,Staff"
hosts[23]="1.227,Nerd-04-Shannon,Staff"
hosts[24]="1.188,Nerd-05-Rosmary,Staff"
hosts[25]="1.244,Nerd-06-Charlotte,Staff"
hosts[26]="1.189,Nerd-07-Jacqui,Staff"
hosts[27]="1.225,LIMEWORKPCMAC-Rob,Staff"
hosts[28]="1.20,XSERV,Raid"

# no ping request
COUNT=1

if [ -z $1 ]; then 
	echo "Passed Variable not set, moving on"
else
	## Override the hosts array with our passed variable.
	hosts=($1)
fi

## Passed variable was not set, loop over all hosts
for index in ${!hosts[*]}
do
  ## Split the host by comma, and store each string in usable variables
  IFS=, read ip hostname group <<< "${hosts[$index]}"
  
  count=$(ping -c $COUNT 192.168.$ip | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')  
  ## Get the date in unix time
  uniDate=$(date +%s)  
  # if count equals 0, we've failed, else, winner winner!
  echo "$uniDate,$ip,$count,$hostname,$group" > "/mnt/raid/farm_script/nodes_response/192.168.$ip.txt"
done
 

## chmod our files so that php can alter the files after they're created. 
$(chmod 777 -R /mnt/raid/farm_script/nodes_response/)

