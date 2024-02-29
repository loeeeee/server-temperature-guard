#!/bin/bash

#------------------
# This script needs grep and sensors-lm to function properly
# This script is intended for water-cooled server whose components are not trusted. It will poeroff tbe server when water temperature becomes unreasonable.
#------------------

# Get CPU tempeture

CPU_temps_raw=$(sensors | grep Package)

temps_pattern="\b([0-9]{2,3})\.[0-9]{1,2}°C\b" # Reg pattern for CPU temp
# temps_pattern="([0-9]{2})" # Bash does not support \d for digits

if [[ $CPU_temps_raw =~ $temps_pattern ]]
then
    CPU_temps="${BASH_REMATCH[1]}"
else
    echo "Failed to get CPU temps"
fi



# Judge Severity of condition

# EMERGENCY

if [[ $CPU_temps -ge 70 ]]
then
    echo "SEVER OVERHEATING, $CPU_temps"
    echo "CPU SEVER OVERHEATING, $CPU_temps" > /dev/kmsg # Write the evidence to kernel mesage, check the measage using 'dmesg' command
    echo "Tempeture checker force poweroff" > /dev/kmsg
    poweroff
fi

# Immediate attention

if [[ $CPU_temps -ge 60 ]]
then
    echo "Overheating, $CPU_temps"
    echo "CPU Overheating, $CPU_temps" > /dev/kmsg # Write the evidence to kernel mesage
    echo "Tempeture checker force shutdown" > /dev/kmsg
    shutdown
fi

# Maintainence required

if [[ $CPU_temps -ge 50 ]]
then
    echo "Warm, $CPU_temps"
    echo "CPU Warm, $CPU_temps" > /dev/kmsg # Write the evidence to kernel mesage
fi

# Delightful

if [[ $CPU_temps -lt 50 ]]
then
    echo "Delightful"
fi

echo "Tempeture checking loop complete"
