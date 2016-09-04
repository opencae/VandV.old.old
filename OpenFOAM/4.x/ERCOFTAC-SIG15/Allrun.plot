#!/bin/sh

for dir in */
do
    (cd $dir
	if [ -x Allrun.plot ]
	then
	    ./Allrun.plot $*
	fi
	)
done

# ----------------------------------------------------------------- end-of-file
