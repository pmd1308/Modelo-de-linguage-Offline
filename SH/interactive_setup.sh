#!/bin/bash

# Enable strict mode
set -e

# Include module files
source ./modules/install.sh
source ./modules/resources_monitor.sh
source ./modules/docker_setup.sh
source ./modules/model_manager.sh

# Main function to orchestrate the entire process
main() {
    echo "Choose one of the options below:"
    echo "1. Install Ollama"
    echo "2. Add a model to Ollama"
    echo "3. Monitor system resources"
    echo "4. Install Docker"
    echo "5. Run the Open WebUI Docker container"
    echo "6. Install Stable Diffusion and Pyenv"
    echo "7. Run an Ollama model"
    echo "8. Exit"
    read -p "Enter the desired option number: " choice
}

# Main execution loop
while true; do
    main
    case $choice in
        1)
            install_ollama
            ;;
        2)
            add_ollama_model
            ;;
        3)
            monitor_resources
            ;;
        4)
            install_docker
            ;;
        5)
            run_open_webui
            ;;
        6)
            install_stable_diffusion
            ;;
        7)
            run_ollama_model
            ;;
        8)
            echo "Exiting the script. Bye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
