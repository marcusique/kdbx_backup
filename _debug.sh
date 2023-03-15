#!/bin/bash

RESULT=$(find . -maxdepth 1 -iname "*.kdbx" -mtime -15 -ls)
echo "RESULT: $RESULT"
