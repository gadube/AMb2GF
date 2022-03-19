#!/bin/bash
SITE_LOCATION="root@example.com:/path/to/webpage" # YOUR SITE LOCATION HERE

ERRORSTRING="Error. Please make sure you've indicated correct parameters"
if [ $# -eq 0 ]
    then
        echo $ERRORSTRING;
elif [ $1 == "live" ]
    then
        if [[ -z $2 ]]
            then
                echo "Running dry-run"
                rsync --dry-run -az --force --delete --progress -e "ssh -p22" src/ $SITE_LOCATION
        elif [ $2 == "go" ]
            then
                echo "Running actual deploy"
                rsync -az --force --delete --progress -e "ssh -p22" src/ $SITE_LOCATION
        else
            echo $ERRORSTRING;
        fi
fi
