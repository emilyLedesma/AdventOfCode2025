#Goal is to get the amount of fresh ids
#Parsing the input and getting the split of where the ranges stop and the id's start
$data = Get-Content .\Input.txt

$splitIndex = [Array]::IndexOf($data, '')

#Grabbing the list of ranges, sorting them by the start and end
$ranges = $data[0..($splitIndex-1)] | Sort-Object {[long]($_ -split '-')[0]}, {[long]($_ -split '-')[1]}

#List to store the distinct ranges and the current range
$distinctRanges = @()
$current = [long[]]$ranges[0].Split('-')

#Going through each range
foreach ($range in $ranges[1..($ranges.Count-1)]) {
    #Getting beginning and end
    $start = [long]$range.Split('-')[0]
    $end = [long]$range.Split('-')[1]

    #Determining if the ranges overlap
    if ($start -le ($current[1] + 1) -and $end -gt $current[1]) {
        #Updating the end of the range
        $current[1] = $end
    }
    elseif ($start -gt ($current[1] + 1)) {
        #Adding current range to the list of distinct ranges and updating the current range
        $distinctRanges += @($current[0].ToString() + '-' + $current[1].ToString())
        $current = [long[]]$range.Split('-')
    }
}

#Adding the last range
$distinctRanges += @($current[0].ToString() + '-' + $current[1].ToString())

#Calculating the total amount of ids
$count = 0L

$distinctRanges | ForEach-Object {
    $object = [long[]]$_.Split('-')
    $count += ($object[1] - $object[0] + 1)
}

#Returning the amount of fresh ids
Write-Host $count 