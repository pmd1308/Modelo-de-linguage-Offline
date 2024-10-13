: <<EOF
Installing Ollama, Docker, Stable Diffusion and Pyenv
EOF

install_ollama() {
    # Install Ollama
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
}

install_docker() {
    # Install Docker
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "Adicionando repositório Docker ao Apt..."
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker instalado com sucesso."
}

install_stable_diffusion() {
    echo "Installing Pyenv dependences..."
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git
    echo "Instalando Pyenv..."
    curl https://pyenv.run | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    echo "Installing Python 3.10 via Pyenv..."
    pyenv install 3.10
    pyenv global 3.10

    echo "Istalling Stable Diffusion WebUI..."
    wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
    chmod +x webui.sh
    ./webui.sh --listen --api
    echo "Stable Diffusion WebUI configurado com sucesso."
}