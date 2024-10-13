#!/bin/bash

# List of allowed models
declare -A models
models=(
    ["moondream"]="ollama run moondream"
    ["llama2"]="ollama run llama2"
    # Add more models here
)

# Function to add a model to Ollama
add_ollama_model() {
    echo "Available models:"
    for model in "${!models[@]}"; do
        echo "- $model"
    done
    read -p "Enter the name of the model you want to add to Ollama: " model_name
    echo "Adding model $model_name to Ollama..."
    ollama pull "$model_name"
    echo "Model $model_name added successfully."
}

# Function to run an Ollama model
run_ollama_model() {
    echo "Available models:"
    for model in "${!models[@]}"; do
        echo "- $model"
    done
    read -p "Enter the name of the model you want to run: " chosen_model
    if [[ -n "${models[$chosen_model]}" ]]; then
        echo "Running model $chosen_model..."
        ${models[$chosen_model]}
        echo "Model $chosen_model executed."
    else
        echo "Model not found in the list. Please make sure to choose a valid model."
    fi
}