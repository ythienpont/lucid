#!/bin/bash

# Change directory to 'lucid'
cd ../lucid || { echo "Failed to change directory to 'lucid'. Exiting."; exit 1; }

# Run the command and redirect output to switch_ex_expected.txt
./docker_lucid.sh interpret ../example_implementation/switch_ex.dpt > ../example_implementation/switch_ex_expected.txt 2>&1

# Inform the user
echo "Output has been written to switch_ex_expected.txt"
