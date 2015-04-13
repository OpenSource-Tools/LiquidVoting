#!/bin/sh                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                               
PIDFILE="/tmp/lf_updated.pid"                                                                                                                                                                                                              
PID=$$                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                               
if [ -f "${PIDFILE}" ] && kill -CONT $( cat "${PIDFILE}" ); then                                                                                                                                                                               
  echo "lf_updated is already running."                                                                                                                                                                                                        
  exit 1                                                                                                                                                                                                                                       
fi                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                               
echo "${PID}" > "${PIDFILE}"                                                                                                                                                                                                                   

DBNAME=liquid_feedback_01
DBUSER=admin
PREFIX=/opt/LiquidVoting/
LOGGERNAME=lf_updated
                                                                                                                                                                                                                                               
while true; do
  sudo su - $DBUSER -c "nice $PREFIX/core/lf_update dbname=$DBNAME 2>&1 | logger -t $LOGGERNAME"
  sudo su - $DBUSER -c "nice $PREFIX/core/lf_update dbname=$DBNAME 2>&1 | logger -t $LOGGERNAME"
  sudo su - $DBUSER -c "nice $PREFIX/core/lf_update_issue_order dbname=$DBNAME 2>&1 | logger -t $LOGGERNAME"
  sudo su - $DBUSER -c "nice $PREFIX/core/lf_update_suggestion_order dbname=$DBNAME 2>&1 | logger -t $LOGGERNAME"
  sleep 5
done                                 
