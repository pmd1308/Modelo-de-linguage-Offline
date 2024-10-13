#!/bin/bash

# Enable strict mode
set -e

# Include module files
source ./modules/install.sh
source ./modules/resources_monitor.sh
source ./modules/docker_setup.sh
source ./modules/model_manager.sh

# Trap to catch interrupt signal (Ctrl+C) and return to the main menu
trap 'echo -e "\nOperation cancelled. Returning to main menu..."' SIGINT

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
            echo "Installing Ollama. Press Ctrl+C to cancel."
            install_ollama || echo "Operation was cancelled."
            ;;
        2)
            echo "Adding a model to Ollama. Press Ctrl+C to cancel."
            add_ollama_model || echo "Operation was cancelled."
            ;;
        3)
            echo "Monitoring system resources. Press Ctrl+C to cancel."
            monitor_resources || echo "Operation was cancelled."
            ;;
        4)
            echo "Installing Docker. Press Ctrl+C to cancel."
            install_docker || echo "Operation was cancelled."
            ;;
        5)
            echo "Running the Open WebUI Docker container. Press Ctrl+C to cancel."
            run_open_webui || echo "Operation was cancelled."
            ;;
        6)
            echo "Installing Stable Diffusion and Pyenv. Press Ctrl+C to cancel."
            install_stable_diffusion || echo "Operation was cancelled."
            ;;
        7)
            echo "Running an Ollama model. Press Ctrl+C to cancel."
            run_ollama_model || echo "Operation was cancelled."
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
