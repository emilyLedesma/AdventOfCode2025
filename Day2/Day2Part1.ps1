#Goal is to get the sum of the invalid ids
#Invalid ids are numbers in the range of the input where the first half is a copy of the second half ex. 33, 990990, 117117
#Setting the input path to the input file 
$InputPath = $PSScriptRoot + '.\Input.txt'

#Initializing variables to get the final answer
$InvalidIds = 0

#Parsing the input into the range list
$Input = Get-Content -Path $InputPath
$Ranges = $Input -split ','

#Going through the ranges
Foreach ($Range in $Ranges) {
    #Getting the start and end value
    $Range = $Range -split '-'
    $Start = [long]$Range[0]
    $End = [long]$Range[1]

    #Iterating through each id in the range
    For ($Id = $Start; $Id -le $End; $Id++) {
        #Check if it can be a pattern
        If ($Id.ToString().Length % 2 -ne 0) {
            continue
        }

        #Getting values to compare first half to second half
        $IdList = [int[]](($Id -split '') -ne '')
        $Half = $IdList.Length / 2
        $Valid = $false

        #Comparing each digit in the first half to the second half
        For ($Index = 0; $Index -lt $Half; $Index++) {
            #Marking valid if it the first half is not the same as the second half
            IF ($IdList[$Index] -ne $IdList[$Half + $Index]) {
                $Valid = $true
                break
            }
        }

        #Checking if invalid and adding it to the total
        If (-not $Valid) {
            $InvalidIds = $InvalidIds + $Id
        }
    }
}

#Giving the sum of the invalid ids
Write-Host $InvalidIds