$data = Get-Content .\input.txt

$beamLocations = @([Array]::IndexOf($data[0] -split '', 'S'))


foreach ($row in $data) {
    $manifold = $row -split ''

    $beamLocations | ForEach-Object {
        if ($manifold[$_] -eq '^') {
            $index = [Array]::IndexOf($beamLocations, $_)
            $beamLocations[$index] = $_ + 1
            $beamLocations += @(($_ - 1))
        }
    }



    Write-Host $beamLocations
}