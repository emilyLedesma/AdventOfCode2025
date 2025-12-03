#Goal is to get the sum of the max joltage of the rows
#Get the sum of the max 12 digit number in the order they appear in the row for each row
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

    #Setting list to hold the max number
    $Max = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    #Going through each number in the row
    For ($BatteryIndex = 0; $BatteryIndex -lt $Batteries.Length; $BatteryIndex++) {
        $Battery = $Batteries[$BatteryIndex]

        #Setting the start value to compare to the max number
        $Start = 0
        #Getting the index of the highest number able to replace based on how many remains in the row
        If ($Batteries.Length - 1 - $BatteryIndex -lt $Max.Length) { 
            $Start = ($Max.Length - 1) - ($Batteries.Length - 1 - $BatteryIndex)
        }

        #Comparing to the current max
        For ($MaxIndex = $Start; $MaxIndex -lt $Max.Length; $MaxIndex++) {
            $CurrentMax = $Max[$MaxIndex]

            #Check if it has a greater value
            If ($Battery -gt $CurrentMax) {
                #Set to the current index in the max list and reset the index afterwards to 0
                $Max[$MaxIndex] = $Battery

                For ($ReplaceIndex = $MaxIndex + 1; $ReplaceIndex -lt $Max.Length; $ReplaceIndex++) {
                    $Max[$ReplaceIndex] = 0
                }
                break
            }
        }
    }
    
    #Adding the max to the total row joltage
    For ($Value = 0; $Value -lt $Max.Length; $Value++) {
        $Jolts = $Max[$Value]

        $Joltage = $Joltage + ($Jolts * [Math]::Pow(10, ($Max.Length - $Value - 1)))
    }
}

#Giving the max joltage
Write-Host $Joltage #175659236361660