#!/bin/bash
#Function to calculate elapsed time:
function timer()
{
    if [[ $# -eq 0 ]]; then
        echo $(date '+%s')
    else
        local  stime=$1
        etime=$(date '+%s')

        if [[ -z "$stime" ]]; then stime=$etime; fi

        dt=$((etime - stime))
        ds=$((dt % 60))
        dm=$(((dt / 60) % 60))
        dh=$((dt / 3600))
        printf '%d:%02d:%02d' $dh $dm $ds
    fi
}
tmr=$(timer)
#Start time stamp
START_TIMESTAMP=`date "+%Y/%m/%d %T"`
echo Start Time : ${START_TIMESTAMP}
echo ""
#----------------------------------------------------------

yes y | ssh-keygen -q -f iac-ci-key -t rsa -N ""

terraform apply -auto-approve

#----------------------------------------------------------
#End time stapm
echo ""
END_TIMESTAMP=`date "+%Y/%m/%d %T"`
echo End Time : ${END_TIMESTAMP}
echo ""
#Elapsed time stapm
printf 'Elapsed Time: %s\n' $(timer $tmr)
echo ""

