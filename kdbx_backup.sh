#!/bin/bash

###################################
# Define Variables
###################################

# Elapsed time
SECONDS=0

# Storage device as defined in your /etc/fstab.
KDBX_LOCATION="/mnt/TimeMachine/kdbx"

# Path were the image of your SD card should be saved to
BACKUP_PATH="/mnt/TimeMachine/kdbx/_backup"

# Folder path for the most recent backup
# MOSTRECENTPATH="/media/TimeMachine/pi-backup/recent"

# Image name
# IMAGENAME="pi-copy"

# Log File location and name
LOGFILE="/var/log/kdbx-backup.log"

###################################
# zip current kdbx files
###################################

echo $(date +%Y-%m-%d_%H-%M-%S) " - Started to zip kdbx files" >>${LOGFILE}
zip $(date +%Y-%m-%d)_backup.zip ${KDBX_LOCATION}/*.kdbx >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) " - Finished to zip kdbx files "$(date +%Y-%m-%d)_backup.zip >>${LOGFILE}

##################################################################
# Remove old kdbx files from _backup folder
##################################################################

echo $(date +%Y-%m-%d_%H-%M-%S) " - Starting to delete zip files older than 90 days in "${BACKUP_PATH} >>${LOGFILE}

# Remove files older than 7 days
sudo find ${BACKUP_PATH}/*.zip -mtime +90 -exec rm -r {} \; >${LOGFILE}

if [ $? != 0 ]; then
    echo $(date +%Y-%m-%d_%H-%M-%S) " - zip files successfully removed" >>${LOGFILE}
    if [ $? != 0 ]; then
        echo $(date +%Y-%m-%d_%H-%M-%S) " - Error: was not able to remove old zip files in ${BACKUP_PATH}. Please check manually" >>${LOGFILE}
        break
    fi
fi

###################################
# Move the backup to the _backup folder
###################################

# Copy the backup to the recent folder
echo $(date +%Y-%m-%d_%H-%M-%S) " - Copying backup to "${BACKUP_PATH} >>${LOGFILE}
sudo mv ${KDBX_LOCATION}/$(date +%Y-%m-%d)_backup.zip ${BACKUP_PATH} >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) " - Backup has been copied to "${BACKUP_PATH} >>${LOGFILE}

# Script finished
duration=$SECONDS
echo $(date +%Y-%m-%d_%H-%M-%S) " - Backup completed in ${duration} seconds" >>${LOGFILE}
echo $(date +%Y-%m-%d_%H-%M-%S) ">>>>> KDBX BACKUP FINISHED<<<<<" >>${LOGFILE}
