#!/bin/bash
#SBATCH --mail-type=END,FAIL         # Mail Events (NONE,BEGIN,FAIL,END,ALL)
#SBATCH --mail-user=amithgopi@tamu.edu   # Replace with your email address
#SBATCH --ntasks=1                   # Run on a single CPU
#SBATCH --time=12:00:00              # Time limit hh:mm:ss
#SBATCH --output=%x_%j.log           # Standard output and error log
#SBATCH --partition=non-gpu          # This job does not use a GPU

echo "Running $1"
if [ -z "$2" ] && [ -z "$3" ]
then
  bin/champsim \
    -warmup_instructions 200000000 \
    -simulation_instructions 1000000000 \
    -traces ~pgratz/dpc3_traces/$1 \
    > $1.txt
else
  bin/champsim \
    -warmup_instructions 200000000 \
    -simulation_instructions 1000000000 \
    -traces ~pgratz/dpc3_traces/$1 \
    > out/$2_$3/$1.txt
fi

### Add more ChampSim runs below.