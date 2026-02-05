#!/bin/bash

STATE="/tmp/run_state.txt"
TODAY=$(date +%Y-%m-%d)
DAY=$(date +%d)

# Decide range based on day of month
if [ "$DAY" -le 22 ]; then
    MIN=10
    MAX=20
else
    MIN=40
    MAX=50
fi

# Initialize daily counter
if [ ! -f "$STATE" ]; then
    echo "$TODAY 0 $((RANDOM%(MAX-MIN+1)+MIN))" > "$STATE"
fi

read LAST_DAY COUNT TARGET < "$STATE"

# New day → reset target
if [ "$LAST_DAY" != "$TODAY" ]; then
    TARGET=$((RANDOM%(MAX-MIN+1)+MIN))
    COUNT=0
fi

# If we already reached today target → exit
if [ "$COUNT" -ge "$TARGET" ]; then
    exit 0
fi

#################################
# PUT YOUR REAL COMMAND HERE
#################################
/path/to/your_real_script.sh
#################################

COUNT=$((COUNT+1))
echo "$TODAY $COUNT $TARGET" > "$STATE"
