#Goal is to get the sum of the invalid ids
#Invalid ids are numbers in the range of the input where there is a pattern of repeating digits ex. 121212, 990990, 333
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
        $IdList = [int[]](($Id -split '') -ne '')

        #Getting values to compare first half to second half
        $Half = $IdList.Length / 2

        #Looping through the first half of the id to check each possible pattern
        For ($Index = 1; $Index -le $Half; $Index++) {
            #Check if the index can divide into the length
            If ($IdList.Length % $Index -eq 0) {
                #Get the pattern
                $pattern = $Id.ToString().Substring(0, $Index)

                #Verify that the pattern matches the id 
                If ($pattern * ($IdList.Length/$Index) -eq $Id.ToString()) {
                    #Add the id to the total
                    $InvalidIds = $InvalidIds + $Id
                    break
                }
            }
        }
    }
}

#Giving the sum of the invalid ids
Write-Host $InvalidIds