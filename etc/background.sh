#!/bin/bash 
# 
# mydaemon          Start/Stop any shell script 
# 
# chkconfig: 345 95 65 
# description: mydaemon  
# processname: mydaemond 
#

# ENVIRONMENT 
# Edit these for your configuration

# Name for the service, used in logging 
NAME=golfscraper

# Name of the user to be used to execute the service 
SCRIPT_USER=deploy

# Example of how to pass paramters into the command 

# In which directory is the shell script that this service will execute 
MYDAEMON_SCRIPTS_DIR=/home/deploy/prod/golf/current/etc

# Construct the command the will cd into the right directory, and invoke the script 
MYDAEMON_COMMAND="cd $MYDAEMON_SCRIPTS_DIR; ./run_scraper.sh"

# How can the script be identified if it appears in a 'ps' command via grep? 
#  Examples to use are 'java', 'python' etc. 
MYDAEMON_PROCESS_TYPE=ruby

# Where to write the log file? 
MYDAEMON_SVC_LOG_FILE=$MYDAEMON_SCRIPTS_DIR/scraper.log

# Where to write the process identifier - this is used to track if the service is already running 
# Note: the script noted in the COMMAND must actually write this file 
PID_FILE=$MYDAEMON_SCRIPTS_DIR/golfscraper.pid

# Load system specific optional arguments 
# Create and populate this file with machine specific settings 
if [ -f /etc/sysconfig/golfscraper ]; then 
    . /etc/sysconfig/golfscraper 
fi

# Is the service already running? If so, capture the process id 
if [ -f $PID_FILE ]; then 
    PID=`cat $PID_FILE` 
else 
    PID="" 
fi

# SERVICE ENTRY POINTS (START/STOP)

# Start Command 
start() { 
    if [ "${PID}" != "" ]; then 
        # Check to see if the /proc dir for this process exists 
        if [ -a /proc/${PID} ]; then 
            # check to make sure this is likely the running service 
            ps aux | grep ${PID} | grep $MYDAEMON_PROCESS_TYPE >> /dev/null 
            # If it is a process of the right type assume that it is mydaemon and just exit 
            # otherwise remove the subsys lock file and start mydaemon 
            if [ "$?" = "0" ]; then 
                exit 1 
            else 
                echo "mydaemon lock file still exists, removing..." 
                rm /var/lock/golfscraper
            fi 
        else 
            # The process running as pid $PID is not a process of the right type, remove subsys 
            # lock and start mydaemon 
            echo "mydaemon lock file still exists, removing..." 
            rm /var/lock/golfscraper
        fi 
    fi 
    echo -n "Starting mydaemon: \n"    
    su - $SCRIPT_USER -c "/bin/sh -c \"$MYDAEMON_COMMAND > $MYDAEMON_SVC_LOG_FILE 2>&1\"" & RETVAL=$? 
    sleep 3 
    touch /var/lock/golfscraper
    exit 0 
}

stop() {

    echo -n $"Stopping mydaemon: " 
    if [ "${PID}" != "" ]; then 
        echo -n "killing " $PID 
        kill ${PID} 
        for i in {1..30} 
        do 
            if [ -n "`ps aux | grep $MYDAEMON_PROCESS_TYPE | grep golfscraper `" ]; then 
                sleep 1 # Still running, wait a second. 
                echo -n . 
            else 
                # stopped 
                rm -f /var/lock/golfscraper
                rm -f $PID_FILE 
                echo 
                exit 0 
            fi 
        done 
    else 
        echo "$NAME is not running" 
        exit 1 
    fi 
    echo "Failed to stop in 30 seconds." 
    kill -QUIT ${PID} # Request a thread dump so we can diagnose a hung shutdown 
    exit 1 
}

case "$1" in 
  start) 
      start 
    ;; 
  stop) 
      stop 
    ;; 
  *) 
    echo $"Usage: $0 {start|stop}" 
    exit 1 
esac
