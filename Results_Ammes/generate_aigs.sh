#!/bin/bash

for x in $(seq 0 9); do
	for y in $(seq 0 9); do
		echo ex$x$y.truth
		./abc/abc -c "read_truth -xf benchmarks/ex$x$y.truth;collapse;sop;strash;dc2;w aigs/ex$x$y.aig;q"
	done
done