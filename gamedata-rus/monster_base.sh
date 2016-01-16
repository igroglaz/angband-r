#!/bin/sh

cp monster_base.txt.orig monster_base.txt

# monster_base
FILENAME=monster_base.txt
PATCHNAME=monster_base.tsv
while read in; do
    ID=`echo "$in" | awk -F'\t' '{print $1}' | sed 's~\/~\\\/~g'`
    if [ "$ID" != "Name" ]; then
        NAME_B=`echo "$in" | awk -F'\t' '{print $2}' | sed 's~\/~\\\/~g'`

        NAME_ORIG=`sed -n 's/^desc:'"$ID"'/'"$ID"'/p' $FILENAME`

        if [ "$NAME_ORIG" = "" ]; then
            echo "(error) $ID not found"
        else
            if [ "$ID" = "$NAME_B" ]; then
                echo "(warning) $ID name not translated"
            else
                # replace the name
                sed -i 's/^desc:'"$ID"'$/desc:'"$NAME_B"'/' $FILENAME
            fi
        fi
    fi
done < $PATCHNAME



