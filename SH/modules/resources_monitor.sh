#!/bin/bash

# Function to detect available drivers and devices
detect_drivers() {
    echo "Detecting system drivers and devices..."

    # GPU detection (NVIDIA, AMD, Intel)
    if command -v nvidia-smi &> /dev/null; then
        echo "NVIDIA driver detected."
        has_nvidia=true
    else
        echo "NVIDIA driver not found."
        has_nvidia=false
    fi

    if command -v rocm-smi &> /dev/null; then
        echo "AMD ROCm driver detected."
        has_amd=true
    else
        echo "AMD ROCm driver not found."
        has_amd=false
    fi

    if command -v intel_gpu_top &> /dev/null; then
        echo "Intel GPU driver detected."
        has_intel=true
    else
        echo "Intel GPU driver not found."
        has_intel=false
    fi
}

# Function to monitor system resources
monitor_resources() {
    detect_drivers

    # Monitor GPU if available
    if [ "$has_nvidia" = true ]; then
        echo "Monitoring NVIDIA GPU with nvidia-smi every 0.5 seconds..."
        watch -n 0.5 nvidia-smi &
    elif [ "$has_amd" = true ]; then
        echo "Monitoring AMD GPU with rocm-smi every 0.5 seconds..."
        watch -n 0.5 rocm-smi &
    elif [ "$has_intel" = true ]; then
        echo "Monitoring Intel GPU with intel_gpu_top every 0.5 seconds..."
        watch -n 0.5 intel_gpu_top &
    else
        echo "No compatible GPU detected. Monitoring CPU and memory only."
    fi

    # Monitor CPU and memory
    echo "Monitoring CPU and memory usage..."
    watch -n 1 top -b -n 1 | head -n 20 &

    # Monitor disk usage
    echo "Monitoring disk usage..."
    watch -n 1 df -h &

    # Monitor temperatures
    if command -v sensors &> /dev/null; then
        echo "Monitoring component temperatures..."
        watch -n 1 sensors &
    else
        echo "'sensors' command not found. Install with 'sudo apt install lm-sensors'."
    fi
}
