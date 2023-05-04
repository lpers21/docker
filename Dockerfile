
# Use the Alpine Linux as the base image
FROM alpine

# Install wget and openssh client
RUN apk add --no-cache wget openssh \
    
    # Download the Docker binary archive
    && wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.17.tgz \

    # Extract the Docker binary archive
    && tar -xvzf docker-20.10.17.tgz \

    # Remove the Docker binary archive
    && rm docker-20.10.17.tgz \

    # Add the Docker binary directory to the system PATH
    && export PATH=$PATH:./docker \

    # Generate a new ecdsa SSH key pair with an empty passphrase
    && ssh-keygen -t ecdsa -f /root/.ssh/id_ecdsa -P ""

# Set the working directory to /root/.ssh
WORKDIR /root/.ssh/

# Set the default command to SSH into the specified host using the generated SSH key
ENTRYPOINT ["ssh", "-i", "/root/.ssh/id_ecdsa", "root@ip172-18-0-102-cha14sg1k7jg00acrct0@direct.labs.play-with-docker.com"]

