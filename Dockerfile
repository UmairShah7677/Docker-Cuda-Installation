# Use Ubuntu 24.04 LTS as the base image
FROM ubuntu:24.04

# Avoid prompts from APT during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for fetching and managing repositories
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common

# Add the CUDA repository and its GPG key
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin && \
    mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda-repo-ubuntu2404-12-6-local_12.6.3-560.35.05-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2404-12-6-local_12.6.3-560.35.05-1_amd64.deb && \
    cp /var/cuda-repo-ubuntu2404-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/

# Update the APT repository cache
RUN apt-get update

# Install the CUDA toolkit
RUN apt-get install -y cuda-toolkit-12-6

# Set up environment variables
RUN echo 'export PATH=/usr/local/cuda/bin:$PATH' >> /etc/bash.bashrc && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> /etc/bash.bashrc

# Optional: Install additional utilities (like vim, screenfetch, etc.)
RUN apt-get install -y vim screenfetch

# Command to run when starting the container
CMD ["bash"]
