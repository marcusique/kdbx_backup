#!/bin/bash

SECONDS=0
KDBX_LOCATION="/mnt/TimeMachine/kdbx"
BACKUP_PATH="/mnt/TimeMachine/kdbx/_backup"
LOGFILE="/var/log/kdbx-backup.log"

echo $(date +%Y-%m-%d_%H-%M-%S) "###### KDBX BACKUP STARTED #####" >>${LOGFILE}

sudo tar -czvf ${BACKUP_PATH}/$(date +%Y-%m-%d_%H-%M-%S)_backup.tar.gz ${KDBX_LOCATION}/*.kdbx --transform 's?.*/??g' >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) " - Finished to tar.gz kdbx files "$(date +%Y-%m-%d_%H-%M-%S)_backup.tar.gz >>${LOGFILE}

# Remove files older than 7 days
sudo find ${BACKUP_PATH}/*.tar.gz -mtime +90 -exec rm -r {} \; >>${LOGFILE}

# Script finished
duration=$SECONDS
echo $(date +%Y-%m-%d_%H-%M-%S) " - Backup completed in ${duration} seconds" >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) "##### KDBX BACKUP FINISHED #####" >>${LOGFILE}

# find . -maxdepth 1 -iname "*.kdbx" -mtime -15
