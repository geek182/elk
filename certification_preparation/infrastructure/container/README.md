# Troubleshooting ¯\\_(ツ)_/¯

### General

Creating a pod </br>
`podman pod create --name elk -p 9200:9200 -p 9300:9300 -p 5601:5601`

Add containers to the pod </br>
`podman run --name es01 -e ELASTIC_PASSWORD="elastic12345" -dt --pod elk docker.elastic.co/elasticsearch/elasticsearch:8.4.3`

`podman run --name kibana -dt --pod elk docker.elastic.co/kibana/kibana:8.4.3`

Start pod </br>
`podman pod start elk`

Stop pod </br>
`podman pod stop elk`


Using podman: </br>

elastic bootstrap failling: </br>

`bootstrap check failure [1] of [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]` </br>

- Set `sudo sysctl -w vm.max_map_count=262144` to the vm created by the podman.

Running manually: </br>
`podman run --name es01 -e ELASTIC_PASSWORD="elastic123" -p 9200:9200 -p 9300:9300 -it docker.elastic.co/elasticsearch/elasticsearch:8.4.3`

`podman run --name kibana  -p 5601:5601 -it docker.elastic.co/kibana/kibana:8.4.3`

Resetting password: </br>
`podman exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -s`
`podman exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system`

Create Kibana token </br>
`podman exec -ti es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana`

proxy issues: </br>
  replace <b>192.168.1.1</b> with your preferably DNS

- `sudo sh -c "echo 'nameserver 192.168.1.1' >> /etc/resolv.conf"`

disabling any annoying proxy :(
- check profiles for any variables set for the proxy (HTTPS_PROXY,HTTP_PROXY,https_proxy,http_proxy)

connecting to the podman machine: </br>
 `wsl -d podman-machine-default`

 connecting to HTTP instead of HTTPS: </br>
 `received plaintext http traffic on an https channel`

### Windows

Redirect docker commands to podman using powershell: </br>
`$Env:DOCKER_HOST = 'npipe:////./pipe/podman-machine-default'`

Searching output strings using Powershell </br>
`podman logs 16d1822299d2 | Select-String "pass"`

 Install Windows terminal
 `winget install Microsoft.WindowsTerminal`