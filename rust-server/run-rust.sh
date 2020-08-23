# NOTE: run in this directory.

# Build an image named 'rust-srv'
docker build -t rust-srv --build-arg "user=$USER" --build-arg uid=(id -u) .

# Runs the ssh server at port 22222, same hostname as the host of the container.
# Mounts the $HOME/src directory into the container.

if [ ! "$(docker ps -q -f name=rust-srv)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=rust-srv)" ]; then
        # Need to remove the old 'rust-srv' container before running a new one.
        docker rm rust-srv
    fi
    # run your container
    docker run -p 127.0.0.1:8642:127.0.0.1:8080 -it \
			--mount="type=bind,source=$HOME/src,destination=$HOME/src" \
	    --mount="type=bind,source=$HOME/.gitconfig,destination=$HOME/.gitconfig,readonly" \
			rust-srv
fi

