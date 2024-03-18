#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <prompt> <config_path>"
    exit 1
fi

PROMPT="$1"
CONFIG="configs/$2"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SANITIZED_PROMPT=$(echo "$PROMPT" | tr ' ' '_')
OUTDIR="logs/$2_${SANITIZED_PROMPT}@${TIMESTAMP}"
echo "Running experiment with prompt: $PROMPT, config: $CONFIG, output directory: $OUTDIR"

# Create the directory
mkdir -p "$OUTDIR"

# Navigate to the script directory if necessary
# cd /path/to/your/scripts

# Execute the commands with the specified arguments
time python main.py --config "$CONFIG" prompt="$PROMPT" save_path="results" outdir="$OUTDIR"
time python main2.py --config "$CONFIG" prompt="$PROMPT" save_path="results" outdir="$OUTDIR"
time xvfb-run python scripts/convert_obj_to_video.py --dir "$OUTDIR" --out "$OUTDIR"

echo "Process completed. Output saved to $OUTDIR"
