#Goal is to get the sum of the max joltage of the rows
#Get the sum of the max 2 digit number in the order they appear in the row for each row
#Setting the input path to the input file 
$InputPath = $PSScriptRoot + '.\Input.txt'

#Variable to store the max joltage
$Joltage = 0

#Parsing the input into the row list
$Input = Get-Content -Path $InputPath
$Rows = $Input -split ' '

#Going through each row
Foreach ($Row in $Rows) {
    #Getting the list of numbers in the row
    $Batteries = [int[]](($Row -split '') -ne '')

    #Setting variables for the max and second max
    $Max = 0
    $SecondMax = 0

    #Going through each number in the row
    For ($Index = 0; $Index -lt $Batteries.Length; $Index++) {
        $Battery = $Batteries[$Index]

        #Check if the number is greater than any of the current maxes
        If ($Battery -gt $Max -and $Index -ne $Batteries.Length - 1) {
            #Reset the second digit if it is setting the first digit so it can be replaced by the next value
            $Max = $Battery
            $SecondMax = 0
        }
        ElseIf ($Battery -gt $SecondMax) {
            $SecondMax = $Battery
        }
    }

    #Add the max to the joltage total
    $Joltage = $Joltage + ($Max * 10) + $SecondMax
}

#Giving the max joltage
Write-Host $Joltage #17694