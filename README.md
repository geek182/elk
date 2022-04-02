# elk
podman instructions:

# See available tags for the docker repository
podman image search --list-tags docker.io/library/elasticsearch --limit 1000


# we are using the 8.1.2 tag
podman pull docker.io/library/elasticsearch:8.1.2 
