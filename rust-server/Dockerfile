FROM rust:1.40

RUN curl -fsSL https://code-server.dev/install.sh | sh -s 

ARG user=dev
ARG uid=1000


# Add cargo to the PATH
RUN echo 'PATH="/usr/local/cargo/bin:$PATH"' >> /etc/profile

# Set the environment critical to run rustc/rustup/cargo
RUN echo export CARGO_HOME="/usr/local/cargo" >> /etc/profile && \
    echo export RUSTUP_HOME="/usr/local/rustup" >> /etc/profile && \
    echo export RUST_VERSION="${RUST_VERSION}" >> /etc/profile

RUN apt-get update
RUN apt-get install -y vim-tiny fish less

# Create a 'dev' user (same password) as vscode doesn't like to run as root.
RUN useradd -G sudo,man,users,ssh -ms /usr/bin/fish -u ${uid} ${user} 
#RUN echo "${user}:dev" | chpasswd

# Create the src directory
RUN mkdir /home/${user}/src
WORKDIR /home/${user}/src

USER ${user}

RUN code-server --install-extension bungcip.better-toml && \
    code-server --install-extension rust-lang.rust

# Run the ssh server.
#EXPOSE 8080
CMD ["code-server", "--auth=none", "--bind-addr=0.0.0.0:8080"] 
