FROM rust:1.40

# Install vscode (https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions)
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
RUN install -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN apt-get install apt-transport-https
RUN apt-get update
RUN apt-get -y install code

# Install open-ssh server (https://docs.docker.com/engine/examples/running_ssh_service/)
RUN apt-get -y install openssh-server 
RUN mkdir /var/run/sshd
RUN echo 'root:dev' | chpasswd
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Libraries needed to run vscode (even headless)
RUN apt-get -y install sudo libx11-xcb1 libasound2

# Create a 'dev' user (same password) as vscode doesn't like to run as root.
RUN useradd -G sudo,man,users,ssh -ms /bin/bash dev 
RUN echo 'dev:dev' | chpasswd

# Create the src directory
RUN mkdir /home/dev/src
WORKDIR /home/dev/src

# Run the ssh server.
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
