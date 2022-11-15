<#
 Capture if pod ELK is running.

 Running the script from the powershell cmd:
 powershell -nologo -noexit -executionpolicy bypass -File .\configure-containers.ps1

#>
$PodmanStatus =  podman pod ps --format "{{.Status}}" --filter name=elk

#Write-Output $variable

if ([string]::IsNullOrWhitespace($PodmanStatus)){ # Check if output is null or empty
    Write-Output "ELK not found"
    Write-Output "Start fresh startup"
    Write-Output "Creating a pod called ELK"
    podman pod create --name elk -p 9200:9200 -p 9300:9300 -p 5601:5601
    Write-Output "Adding elastic container to pod ELK"
    podman run --name es01 -e ELASTIC_PASSWORD="elastic12345" -dt --pod elk docker.elastic.co/elasticsearch/elasticsearch:8.4.3
    Write-Output "Adding kibana container to pod ELK"
    podman run --name kibana -dt --pod elk docker.elastic.co/kibana/kibana:8.4.3

}
elseif ($PodmanStatus -eq "Exited") {
    Write-Output "ELK is not running"
    Write-Output "Bringing pod ELK back"
    podman pod start elk
}
else {
    Write-Output "ELK is running"
}