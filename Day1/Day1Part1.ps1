#Setting the input path to the input file 
$InputPath = $PSScriptRoot + '.\Input.txt'

#Initializing variables to get the final password and current dial positions
$Password = 0
$DialPosition = 50

#Parsing the input into the rotation list
$Input = Get-Content -Path $InputPath
$Rotations = $Input -split ' '

#Looping through each rotation and rotating the dial
Foreach($Rotation in $Rotations) {
    #Get the direction and the amount
    $Direction = $Rotation[0]
    $Amount = [int]$Rotation.Substring(1)
    
    #Reduce the full rotations from the amount
    While ($Amount -gt 100) {
        $Amount = $Amount - 100
    }

    #Check if the dial will go over 99 or 0 and modify the dial position accordingly
    If ($Direction -eq 'L' -and $DialPosition - $Amount -lt 0) {
        $DialPosition = 100 + ($DialPosition - $Amount)
    }
    ElseIf ($Direction -eq 'R' -and $DialPosition + $Amount -gt 99) {
        $DialPosition = ($DialPosition + $Amount) - 100
    }
    ElseIf ($Direction -eq 'L') {
        $DialPosition = $DialPosition - $Amount
    } 
    ElseIf ($Direction -eq 'R') {
        $DialPosition = $DialPosition + $Amount
    } 

    #Check if the dial position is 0 and update the password
    If ($DialPosition -eq 0) {
        $Password = $Password + 1
    }
}

#Get the final password
Write-Host $Password
