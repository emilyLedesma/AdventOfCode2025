#Goal is to get the count of ids that are in the range of fresh ids
#Parsing the input and getting the split of where the ranges stop and the id's start
$data = Get-Content .\Input.txt
$splitIndex = [Array]::IndexOf($data, '')

#Diving them into the range list and id list
$ranges = $data[0..($splitIndex-1)]
$ids = $data[($splitIndex+1)..($data.Length-1)]

#Filtering the ids to where they are within one of the ranges
$fresh = $ids | Where-Object {
    $id = [long]$_
    $ranges | Where-Object {
        $range = $_.Split('-')
        $id -ge [long]$range[0] -and $id -le [long]$range[1]
    }
}

#Returning the length of the list of fresh ids to get the count
Write-Host $fresh.Length