# Troubleshooting ¯\_(ツ)_/¯

### Windows
Using podman: </br>

- Set `sudo sysctl -w vm.max_map_count=262144` to the vm created by the podman.
- Searching output strings using Powershell `podman logs 16d1822299d2 | Select-String "pass"`

Running manually: </br>

`podman run --name es01 -e ELASTIC_PASSWORD="elastic123" -p 9200:9200 -p 9300:9300 -it docker.elastic.co/elasticsearch/el
  asticsearch:8.4.3`

Resetting password: </br>

`podman exec -it  elastic /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -s`