#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
        "MASTER") echo "master"
                  exit 0
                  ;;
        "BACKUP") echo "bkp"
                  exit 0
                  ;;
        "FAULT")  echo "fault"
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
esac