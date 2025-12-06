#Goal is to get the amount of times the dial touches 0 going through the rotations
#Initializing variables to get the final password and current dial position
$password = 0
$dialPosition = 50

#Parsing the input into the rotation list
$data = Get-Content .\input.txt

#Looping through each rotation and rotating the dial
switch ($data) {
    #Get the starting position and full rotations
    { $_ -ne $null } {
        $startPosition = $dialPosition
        $password += [math]::Floor([int]$_.Substring(1) / 100)
    }
    #Rotate
    { $_[0] -eq 'L' } {
        $dialPosition = $dialPosition - ([int]$_.Substring(1) % 100)
    }
    { $_[0] -eq 'R' } {
        $dialPosition = $dialPosition + ([int]$_.Substring(1) % 100)
    }
    #Fix position
    { $dialPosition -lt 0 } {
        $dialPosition += 100
    }
    { $dialPosition -gt 99 } {
        $dialPosition -= 100
    }
    #Verify if 0 or passed 0
    { $dialPosition -eq 0 -or ($_[0] -eq 'L' -and $startPosition -lt $dialPosition -and $startPosition -ne 0) -or ($_[0] -eq 'R' -and $startPosition -gt $dialPosition -and $startPosition -ne 0)} {
        $password = $password + 1
    }
}

#Get the final password
Write-Host $password