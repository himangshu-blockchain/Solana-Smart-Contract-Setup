FROM ubuntu:latest

# Prevents interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive 
WORKDIR /app
SHELL ["/bin/bash", "-c"]
RUN apt update && \
    apt upgrade -y &&\
    apt install -y ca-certificates
RUN update-ca-certificates


# # Update and install dependencies
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    build-essential \
    pkg-config \
    libudev-dev \
    llvm curl \
    libclang-dev \
    protobuf-compiler \
    libssl-dev && \
    apt clean && rm -rf /var/lib/apt/lists/*



# Quick Installation 
RUN curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash


# Add installed tools to system PATH.
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"
ENV PATH="/root/.cargo/bin:${PATH}" 
RUN rustc --version && \
    avm --version && \
    anchor --version && \
    solana --version

# Generate Solana Keygen
RUN solana-keygen new --no-bip39-passphrase

# After create Project change the following.
# cargo update bytemuck_derive@1.9.2 --precise 1.8.1

