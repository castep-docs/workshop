#!/bin/bash

# This file contains the aliases that are used in the workshop to make running
# the commands easier. You can source this file to make them available in your current shell.
# For example:
#
# source /course_materials/vm_aliases.sh

# Function to prepend a command to an executable
prepend_command() {
  local command=$1
  local executable=$2
  alias "$executable"="$command $executable"
}

# Read the list of executables from the serial configuration file
serial_executables=$(cat ./serial_executables.conf)

# Loop over the serial executables and create aliases
for exe in $serial_executables; do
  prepend_command "castep-serial" "$exe"
done

# For the MPI executables, prepend castep-mpi to mpirun 
# and that will anyway ensure that the mpi versions of the executables are used
alias "mpirun"="castep-mpi mpirun"