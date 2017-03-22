#!/bin/bash
export SPARK_HOME=~/spark-2.1.0-bin-hadoop2.7
for file in test_maxpool_backward.dml test_maxpool.dml
do
for pool in 1 3 5
do
	for stride in 1 2 3
	do
		for pad in 0 1 2
		do
			$SPARK_HOME/bin/spark-submit SystemML.jar -f $file -nvargs stride=$stride pad=$pad out=out_cp.csv pool=$pool
			$SPARK_HOME/bin/spark-submit SystemML.jar -f $file -gpu -nvargs stride=$stride pad=$pad out=out_gpu.csv pool=$pool
			$SPARK_HOME/bin/spark-submit SystemML.jar -f compare.dml -args out_cp.csv out_gpu.csv  $file" stride="$stride" pad="$pad" pool="$pool
		done
	done
done
done
