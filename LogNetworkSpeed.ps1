# log a network interfaces LinkSpeed


function Start-LinkSpeedLog {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Seconds,
        [Parameter()]
        [string]$Adapter
    )

    foreach ($second in 1..$Seconds) {

        # Concat date and network adapter name,linkspeed,status
        $date = Get-Date -Format 'dd-MM-yyyy HH:mm:ss'
        $networkAdapterStats = Get-NetAdapter $Adapter | Select-Object Name,LinkSpeed,Status
        $logString = "$date | Name: $($networkAdapterStats.Name) | Link Speed: $($networkAdapterStats.LinkSpeed) | Status: $($networkAdapterStats.Status)"

        # create log.txt or append log.txt with log string
        $logFileName = log.txt
        $isLog = Test-Path -Path 

        if ($isLog) {
            $logString | Out-File $logFileName -Append
        }
        else {
            $logString | Out-File $logFileName
        }

        Start-Sleep -Seconds 1
    }   
}

$getSeconds = Read-Host "How many seconds would you like to run?"
$getAdapter = Read-Host "Which network adapter would you like audit?"

Start-LinkSpeedLog -Seconds $getSeconds -Adapter $getAdapter
