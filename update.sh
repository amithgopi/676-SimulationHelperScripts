#!/bin/bash
[ -d "~/logs" ] && exec 2>&1 > ~/logs/update_log_$$.txt

wait_to_complete () {
    echo "In wait loop..."
    COUNT=2
    while [ ! $COUNT -eq 1 ]
    do
        COUNT=`squeue -u amithgopi | wc -l`
        sleep 60
    done
    echo "Jobs complete, moving to next process..."
}

#********************************************************************************#

DIR_BRANCH="./branch"
PREDICTOR="bimodial"
DIR="$DIR_BRANCH/$PREDICTOR/$PREDICTOR.cc"

wait_to_complete

## Case bimodial 2
sed -i 's/BIMODAL_TABLE_SIZE = 16384/BIMODAL_TABLE_SIZE = 8192/g' "$DIR"
sed -i 's/BIMODAL_PRIME = 16381/BIMODAL_PRIME = 8191/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 2
wait_to_complete

## Case bimodial 3
sed -i 's/BIMODAL_TABLE_SIZE = 8192/BIMODAL_TABLE_SIZE = 16384/g' "$DIR"
sed -i 's/BIMODAL_PRIME = 8191/BIMODAL_PRIME = 16381/g' "$DIR"
sed -i 's/COUNTER_BITS = 2/COUNTER_BITS = 1/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 3
wait_to_complete

#********************************************************************************#

PREDICTOR_OLD="$PREDICTOR"
PREDICTOR="perceptron"
DIR="$DIR_BRANCH/$PREDICTOR/$PREDICTOR.cc"
sed "s/bimodal/$PREDICTOR/g" my_config.json

## Case perceptron 1
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 1
wait_to_complete

## Case perceptron 2
# sed -i 's/PERCEPTRON_HISTORY = 24/PERCEPTRON_HISTORY = 24/g' "$DIR"
# sed -i 's/PERCEPTRON_BITS = 8/PERCEPTRON_BITS = 8/g' "$DIR"
sed -i 's/NUM_PERCEPTRONS = 81/NUM_PERCEPTRONS = 81/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 2
wait_to_complete

## Case perceptron 3
# sed -i 's/PERCEPTRON_HISTORY = 24/PERCEPTRON_HISTORY = 24/g' "$DIR"
sed -i 's/PERCEPTRON_BITS = 8/PERCEPTRON_BITS = 4/g' "$DIR"
sed -i 's/NUM_PERCEPTRONS = 81/NUM_PERCEPTRONS = 163/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 3
wait_to_complete

#********************************************************************************#

PREDICTOR_OLD="$PREDICTOR"
PREDICTOR="gshare"
DIR="$DIR_BRANCH/$PREDICTOR/$PREDICTOR.cc"
sed "s/$PREDICTOR_OLD/$PREDICTOR/g" my_config.json
## Case gshare 1
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 1
wait_to_complete

## Case gshare 2
# sed -i 's/GLOBAL_HISTORY_LENGTH 14/GLOBAL_HISTORY_LENGTH 14/g' "$DIR"
sed -i 's/GS_HISTORY_TABLE_SIZE 16384/GS_HISTORY_TABLE_SIZE 8192/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 2
wait_to_complete

## Case gshare 3
sed -i 's/GLOBAL_HISTORY_LENGTH 14/GLOBAL_HISTORY_LENGTH 7/g' "$DIR"
sed -i 's/GS_HISTORY_TABLE_SIZE 8192/GS_HISTORY_TABLE_SIZE 16384/g' "$DIR"
echo "Running make...."
make
echo "Scheduling jobs..."
./auto.sh sims "$PREDICTOR" 3
wait_to_complete
