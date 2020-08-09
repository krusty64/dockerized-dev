# NOTE: run in this directory.

# Build an image named 'rust-dev'
docker build . -t rust-dev

# Runs the ssh server at port 22222, same hostname as the host of the container.
# Mounts the $HOME/src directory into the container.

if [ ! "$(docker ps -q -f name=rust-dev)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=rust-dev)" ]; then
        # Need to remove the old 'rust-dev' container before running a new one.
        docker rm rust-dev
    fi
    # run your container
    docker run -p 22222:22 -it \
	    --mount="type=bind,source=$HOME/src,destination=/home/dev/src" \
	    --mount="type=bind,source=$HOME/.gitconfig,destination=/home/dev/.gitconfig,readonly" \
	    --name=rust-dev -d rust-dev 
fi
