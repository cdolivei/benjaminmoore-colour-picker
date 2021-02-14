function Get-BenjaminmooreData {
    [cmdletbinding()]
    param()

    $total = 0
    $start = 1
    $number = 100
    $retrievedCount = 0
    do {
        $url = "https://www.benjaminmoore.com/benjaminmoore/SiteSearchApi/Search?category=color&language=en-CA&num=${number}&q=&start=${start}"
        $results = Invoke-RestMethod $url
        $total = $results.searchInformation.totalResults
        $retrievedCount += $results.items.Count

        foreach ( $entry in $results.items ) {
            $entry
        }
        Write-Progress -Activity "Downloading data from Benjamin Moore" -PercentComplete ( $retrievedCount / $total * 100 )
        Start-Sleep -Seconds 5
        $start += $number
    } while ( $retrievedCount -lt $total )
}

function Find-MatchingColours {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)][array]$data,
        [Parameter(Mandatory=$true)][int]$r,
        [Parameter(Mandatory=$true)][int]$b,
        [Parameter(Mandatory=$true)][int]$g,
        [Parameter(Mandatory=$false)][int]$delta
    )
    $data | Where-Object {
        ( $_.r -ge ( $r - $delta ) ) -and ( $_.r -le ( $r + $delta ) ) -and `
        ( $_.b -ge ( $b - $delta ) ) -and ( $_.b -le ( $b + $delta ) ) -and `
        ( $_.g -ge ( $g - $delta ) ) -and ( $_.g -le ( $g + $delta ) )
    }
}