# elk
podman instructions:

## See available tags in the docker repository
`podman image search --list-tags docker.io/library/elasticsearch --limit 1000`


## we are using the 8.1.2 tag
`podman pull docker.io/library/elasticsearch:8.1.2`

## running container --interactive mode
`podman run -it -p 9200:9200 -p 9300:9300 docker.io/library/elasticsearch:8.1.2`
