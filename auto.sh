#!/bin/bash
[ ! -d ~/logs ] && mkdir ~/logs
exec 2>&1 > ~/logs/auto_script_log_$$.txt


while read p; do
  echo "Submitting job for SIM - $p"
  if [ -z "$2" ]
  then
    sbatch --job-name="$p" job_submit_auto.sh "$p"
  else
    mkdir "out/$2_$3"
    sbatch --job-name="$p" job_submit_auto.sh "$p" "$2" "$3"
  fi
done <$1