#!/bin/bash

# Set environment variables for directory and file paths
LUCID_DIR="../../lucid"
EXAMPLE_DIR="../examples/broadcast_example"
DPT_FILE="$EXAMPLE_DIR/broadcast_ex.dpt"
EXPECTED_FILE="$EXAMPLE_DIR/broadcast_ex_expected.txt"

# Change to the 'lucid' directory or exit if it fails
cd "$LUCID_DIR" || { echo "Failed to change directory to '$LUCID_DIR'. Exiting."; exit 1; }

# Run the 'interpret' command and redirect both stdout and stderr to the expected file
./docker_lucid.sh interpret "$DPT_FILE" > "$EXPECTED_FILE" 2>&1

# Inform the user where interpreter output has been written
echo "Interpreter output has been written to $EXPECTED_FILE"

# Run the 'compile' command to generate the equivalent P4 code
./docker_lucid.sh compile "$DPT_FILE"

# Inform the user of successfull compilation
echo "$DPT_FILE successfully compiled"

