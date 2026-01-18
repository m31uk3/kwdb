# Daylight Savings Time


On my servers, I used

#zdump -v /etc/localtime | grep 2007

to verify the 2007 timezone settings. Mine showed April 1st as the date of change... and not March 11.

I went to http://www.twinsun.com/tz/tz-link.htm and downloaded tzdata2006p.tar.gz. I un-tared this file into a temp directory and executed

1. zic -d /tmp/zoneinfo northamerica

to compile the timezone data files. I then copied the EST5EDT file to /usr/share/zoneinfo/ directory and America/Montreal file into /usr/share/zoneinfo/America directory. Doing a quick test will make sure these new files are good.

1. zdump -v /usr/share/zoneinfo/EST5EDT | grep 2007
1. zdump -v /usr/share/zoneinfo/America/Montreal | grep 2007

lastly I linked the localtime file

1. ln -fs /etc/localtime /usr/share/zoninfo/EST5EDT
1. zdump -v /etc/localtime | grep 2007

the expected output should look a little like thi

/etc/localtime Sun Mar 11 06:59:59 2007 UTC = Sun Mar 11 01:59:59 2007 EST isdst=0 gmtoff=-18000
/etc/localtime Sun Mar 11 07:00:00 2007 UTC = Sun Mar 11 03:00:00 2007 EDT isdst=1 gmtoff=-14400
/etc/localtime Sun Nov 4 05:59:59 2007 UTC = Sun Nov 4 01:59:59 2007 EDT isdst=1 gmtoff=-14400
/etc/localtime Sun Nov 4 06:00:00 2007 UTC = Sun Nov 4 01:00:00 2007 EST isdst=0 gmtoff=-18000

