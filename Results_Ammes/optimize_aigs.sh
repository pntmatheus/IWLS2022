#!/bin/bash


for x in $(seq 0 9); do
	for y in $(seq 0 9); do
		if [ ${x}${y} -ne 63 ]; then
			echo ex$x$y
			sh optimize_aig_dc2.sh ./aigs_tt/aigs_dc2/ex$x$y.aig
			sh optimize_aig_resyn2.sh ./aigs_tt/aigs_resyn2/ex$x$y.aig
			sh optimize_aig_dc2_resyn2_mfs.sh ./aigs_tt/aigs_sep/ex$x$y.aig
			sh optimize_aig_dc2_resyn2_mfs_alt.sh ./aigs_tt/aigs_alt/ex$x$y.aig
		fi
	done
done