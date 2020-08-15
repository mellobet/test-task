#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
        "MASTER") echo "master"
                  nginx -g "daemon off;"
                  exit 0
                  ;;
        "BACKUP") echo "bkp"
                  #nginx -s stop
                  exit 0
                  ;;
        "FAULT")  echo "fault"
                  nginx -s stop
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
esac