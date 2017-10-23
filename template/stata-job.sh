#!/bin/bash

module purge

# Load Stata module
module load stata 

# Use larger tmp data folder
export TMPDIR=/tmpdata

# The real stata-mp command
stata-mp -s do test.do
