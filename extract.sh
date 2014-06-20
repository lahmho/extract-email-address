#s script will parse an mbox file, displaying all of the From: email addresses, removing ones that
# are from postmaster, mail admins, etc
 
FILE=$1
if [ ! -r $FILE ]; then
 if [ -r /var/spool/mail/$FILE ]; then
  FILE="/var/spool/mail/$FILE"
 else
  echo "Sorry! Neither $FILE nor /var/spool/mail/$FILE exists, or I can't read them"
  exit
 fi
fi
 
grep "^From:" $FILE | egrep -vi \
"(postoffice|\
postman|\
administrator|\
bounce|\
MAILER-DAEMON|\
postmaster|\
Mail Administrator|\
Auto-reply|\
out of office|\
Mail Delivery System|\
Email Engine|\
Mail Delivery Subsystem|\
Mail.Administrator|\
non.deliverable)" |\
egrep -io "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.([A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)" |\
tr '[A-Z]' '[a-z]' |\
sort | uniq

