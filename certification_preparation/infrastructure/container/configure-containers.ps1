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
    
}
elseif ($PodmanStatus -eq "Exited") {
    Write-Output "ELK is not running"
    Write-Output "Bringing pod ELK back"
    podman pod start elk
}
else {
    Write-Output "ELK is running"
}