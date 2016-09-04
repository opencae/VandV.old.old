#!/bin/sh

for dir in */
do
    (cd $dir
	./Allrun.plot $*
	)
done

# ----------------------------------------------------------------- end-of-file
