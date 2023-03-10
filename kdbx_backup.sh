#!/bin/bash

###################################
# Define Variables
###################################

# Elapsed time
SECONDS=0

# Storage device as defined in your /etc/fstab.
KDBX_LOCATION="/mnt/TimeMachine/kdbx"

# Path where kdbx files should be saved to
BACKUP_PATH="/mnt/TimeMachine/kdbx/_backup"

# Log File location and name
LOGFILE="/var/log/kdbx-backup.log"

###################################
# START
###################################
echo $(date +%Y-%m-%d_%H-%M-%S) ">>>>> KDBX BACKUP STARTED <<<<<" >>${LOGFILE}

###################################
# zip current kdbx files
###################################

echo $(date +%Y-%m-%d_%H-%M-%S) " - Started to zip kdbx files" >>${LOGFILE}
zip ${BACKUP_PATH=}/$(date +%Y-%m-%d)_backup.zip ${KDBX_LOCATION}/*.kdbx -D -j -v >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) " - Finished to zip kdbx files "$(date +%Y-%m-%d)_backup.zip >>${LOGFILE}

# Remove files older than 7 days
sudo find ${BACKUP_PATH}/*.zip -mtime +90 -exec rm -r {} \; >>${LOGFILE}

# Script finished
duration=$SECONDS
echo $(date +%Y-%m-%d_%H-%M-%S) " - Backup completed in ${duration} seconds" >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) ">>>>> KDBX BACKUP FINISHED<<<<<" >>${LOGFILE}
