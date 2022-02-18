#!/bin/bash
exec 2>&1 > ~/logs/auto_script_log_$$.txt

while read p; do
  echo "Submitting job for SIM - $p"
  sbatch --job-name="$p" job_submit_auto.sh "$p"
done <$1