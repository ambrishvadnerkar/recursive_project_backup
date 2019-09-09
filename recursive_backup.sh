#!/bin/bash

#$1 = Remote server ip
#$2 = Remote server location for backup
#$3 = Local folder name for backup
#$4 (optional parameter) = list of files/directories, which needs to be excluded in backup
# For example = (1) sh backup.sh 10.30.3.54 /home project1 logs
# For example = (2) sh backup.sh 10.30.3.54 /home project1  /home/*/logs

#Total number of daily backups

dailytot=7
mnthtot=2
weektot=2
((intr=dailytot-1))
((mnthintr=mnthtot-1))
((weekintr=weektot-1))


if [ $# -gt 2 ]; then

	day="$(date +%a)"
	dt="$(date +%d)"

############ CODE FOR DAILY BACKCUP STARTS ############
	for(( i=0; i <= $dailytot; i++ ))
	do

		drs="/files-backup/$3/daily"$i;

			if [ $i != $dailytot ]
			then


				if [ -d "$drs" ]
				then
					cnt="$i"

				else

					
					if [ $i != 0 ] 
					then
						
						t=$i
						
						while [ $t != 0 ]
						do

							((nw=t-1))
							`mv /files-backup/$3/daily$nw /files-backup/$3/daily$t`
							
							((t--))

						done
						
						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial --delete-excluded --delete --progress  --exclude $4 root@$1:$2 /files-backup/$3/daily0
						else
							rsync -rtLv --partial --delete-excluded --delete --progress  root@$1:$2 /files-backup/$3/daily0
						fi
						break
						# exit


					 else
						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial --delete-excluded --delete --progress  --exclude $4 root@$1:$2 /files-backup/$3/daily0
						else
							rsync -rtLv --partial --delete-excluded --delete --progress  root@$1:$2 /files-backup/$3/daily0
						fi
						break
						#exit
						
					fi
					
				fi
			else
					
				
					((d=intr))
					
					while [ $d -ge 0 ]
					do
						
						((nx=d+1))
						`mv /files-backup/$3/daily$d /files-backup/$3/daily$nx`
						((d--))

					done
					
					`mv /files-backup/$3/daily$dailytot /files-backup/$3/daily0`

						
					if [ $# -gt 3 ]; then
						rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/daily0
					else
						rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/daily0
					fi
					break
			fi
	done
############ CODE FOR DAILY BACKCUP ENDS ############

############ CODE FOR MONTHLY BACKCUP STARTS ############


if [ $dt -eq 1 ] || [ ! -d "/files-backup/$3/monthly0" ]; then

for(( i=0; i <= $mnthtot; i++ ))
	do

		drs="/files-backup/$3/monthly"$i;

			if [ $i != $mnthtot ]
			then


				if [ -d "$drs" ]
				then
					cnt="$i"

				else

					
					if [ $i != 0 ] 
					then
						
						t=$i
						
						while [ $t != 0 ]
						do

							((nw=t-1))
							`mv /files-backup/$3/monthly$nw /files-backup/$3/monthly$t`
							((t--))

						done
						
						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/monthly0
						else
							rsync -rtLv --partial --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/monthly0
						fi
						break
						# exit


					 else
						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/monthly0
						else
							rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/monthly0
						fi
						break
						# exit
						
					
					fi
					
				fi
			else
					
				
					((d=mnthintr))
					
					while [ $d -ge 0 ]
					do
						
						((nx=d+1))
						`mv /files-backup/$3/monthly$d /files-backup/$3/monthly$nx`
						((d--))

					done
					
					`mv /files-backup/$3/monthly$mnthtot /files-backup/$3/monthly0`
					
					
					if [ $# -gt 3 ]; then
						rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/monthly0
					else
						rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/monthly0
					fi
					break
					
			fi
	done
fi

############ CODE FOR MONTHLY BACKCUP ENDS ############

############ CODE FOR WEEKLY BACKCUP STARTS ############


if [ $day == "Sun" ] || [ ! -d "/files-backup/$3/weekly0" ]; then

for(( i=0; i <= $weektot; i++ ))
	do

		drs="/files-backup/$3/weekly"$i;

			if [ $i != $weektot ]
			then


				if [ -d "$drs" ]
				then
					cnt="$i"

				else

					
					if [ $i != 0 ] 
					then
						
						t=$i
						
						while [ $t != 0 ]
						do

							((nw=t-1))
							`mv /files-backup/$3/weekly$nw /files-backup/$3/weekly$t`
							((t--))

						done
						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/weekly0
						else
							rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/weekly0
						fi
						break
						# exit


					 else

						
						if [ $# -gt 3 ]; then
							rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/weekly0
						else
							rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/weekly0
						fi
						break
						# exit
						
					
					fi
					
				fi
			else
					
				
					((d=weekintr))
					
					while [ $d -ge 0 ]
					do
						
						((nx=d+1))
						`mv /files-backup/$3/weekly$d /files-backup/$3/weekly$nx`						
						((d--))

					done
					
					`mv /files-backup/$3/weekly$weektot /files-backup/$3/weekly0`
					
						
					if [ $# -gt 3 ]; then
						rsync -rtLv --partial  --delete-excluded --delete --progress --exclude $4 root@$1:$2 /files-backup/$3/weekly0
					else
						rsync -rtLv --partial  --delete-excluded --delete --progress root@$1:$2 /files-backup/$3/weekly0
					fi
					break
					
			fi
	done
fi
############ CODE FOR WEEKLY BACKCUP ENDS ############

fi
