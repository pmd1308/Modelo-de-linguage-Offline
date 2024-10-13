#!/bin/bash

# Run docker
run_open_webui() {
    echo "Executing Docker and Open WebUI..."
    docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
    echo "Open WebUI is running."
}
