#/bin/bash

for i in design_[0-9]*; do for j in {2..10};  do echo $i, $j; time Rscript metagene_chipseq_3.R  $i $j; done; done 2>&1 | tee timing.log


