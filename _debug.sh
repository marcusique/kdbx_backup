#!/bin/bash
zip $(date +%Y-%m-%d)_backup.zip /mnt/TimeMachine/kdbx/*.kdbx -D
