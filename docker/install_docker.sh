#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "install for LINUX"
	sudo apt-get install -y curl

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
	   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
	   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update
	sudo apt-get install -y docker-ce nvidia-docker2  build-essential cmake

	# Add user to docker's group
	sudo usermod -aG docker ${USER}
	

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "=== Installing for macOS (Intel or Apple Silicon) ==="

    ARCH=$(uname -m)
    echo "Detected architecture: $ARCH"

    # Install Homebrew if missing
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew already installed."
    fi

    # Install Docker Desktop (auto-selects Intel/ARM build)
    if ! ls /Applications | grep -q "Docker.app"; then
        echo "Installing Docker Desktop..."
        brew install --cask docker
    else
        echo "Docker Desktop already installed."
    fi

    # Intel-specific notice
    if [[ "$ARCH" == "x86_64" ]]; then
        echo "Intel Mac detected — using x86_64 Docker Desktop build."
    fi

    # Apple Silicon notice
    if [[ "$ARCH" == "arm64" ]]; then
        echo "Apple Silicon detected — using ARM Docker Desktop build."
    fi

    echo "⚠️  IMPORTANT: You must open Docker.app manually once after installation."
fi



if [ -d "${HOME}/trento_lab_home" ]; then
  echo "Directory trento_lab_home exists."
else
    echo "Creating trento_lab_home dir."
    mkdir -p ${HOME}/trento_lab_home/ros_ws/src
fi

echo "Copying .ssh folder with user permissions"
sudo cp -R $HOME/.ssh/ $HOME/trento_lab_home/.ssh/
sudo chown -R $USER:$USER $HOME/trento_lab_home/.ssh 




echo -e "${COLOR_BOLD}To start docker, reboot the system!${COLOR_RESET}"
