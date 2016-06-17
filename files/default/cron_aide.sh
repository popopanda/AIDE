#!/usr/bin/env bash

MYDATE=$(date +%Y-%m-%d)
MYFILENAME="AIDE-"${MYDATE}.txt

/bin/echo "Aide check !! $(date)" > /tmp/$MYFILENAME
sudo /usr/bin/aide.wrapper --check > /tmp/$MYFILENAME
/bin/echo "****************DONE******************" >> /tmp/$MYFILENAME
/usr/bin/mail -s"$MYFILENAME `date`" <insert email here> < /tmp/$MYFILENAME
/bin/rm /tmp/myAide.txt
