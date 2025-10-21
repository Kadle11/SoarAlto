#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 [dir] [thcnt]"
  exit 1
fi
RSTDIR=$1
thcnt=$2
ttype=$3

F="pgstat-th${thcnt}.log"

if [[ $ttype == 1 ]]; then
    # Nomad
    grep "success_nr" $RSTDIR/$F | awk '{print $2}' | awk 'NR==1{start=$0} {end=$0} END{print "Success Start:", start; print "Sucess End:", end; print end-start}'
    grep "retry_nr" $RSTDIR/$F | awk '{print $2}' | awk 'NR==1{start=$0} {end=$0} END{print "Retry Start:", start; print "Retry End:", end; print end-start}'
  else
    grep "pgpromote_success" $RSTDIR/$F | awk '{print$2}' | awk 'NR==1{start=$0} {end=$0} END{print "Start:", start; print "End:", end; print end-start}'
  fi


cat "$RSTDIR/time-th${thcnt}.log"