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
    clang llvm lld curl \
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

RUN rustup install nightly && \
    rustup default nightly
# Generate Solana Keygen
RUN solana-keygen new --no-bip39-passphrase

## Increase memory stack
ENV RUST_MIN_STACK=67108864


# Build a sample workspace for download packages.
COPY ./Project /app 
RUN cd /app/project && anchor build

# Copy your script (e.g., entrypoint.sh) into the container
COPY entrypoint.sh /entrypoint.sh  
# Make the script executable
RUN chmod +x /entrypoint.sh  
# Set the new entrypoint
ENTRYPOINT ["/entrypoint.sh"]