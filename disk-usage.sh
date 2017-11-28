#!/bin/sh
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $used -ge 80 ]; then
    echo "The partition \"$partition\" on $(hostname) has used $used% at $(date)" | mail -s "$(hostname) - Disk space alert: $used% used" [your_email_address_goes_here]
  fi
done