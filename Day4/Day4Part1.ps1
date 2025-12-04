#Goal is to get the amount of accessible rolls
#Remove accessible rolls and keep iterating until there are no more accessible, get the total
#Setting the input path to the input file 
$InputPath = $PSScriptRoot + '.\Input.txt'

#Variable to store the amount of accessible rolls and if there are any
$Accessible = 0

#Parsing the input into the row list
$Input = Get-Content -Path $InputPath
$Diagram = [string[]]$Input -split ' '

#Go through each row in the diagram
For ($Row = 0; $Row -lt $Diagram.Length; $Row++) {
    $CurrentRow = $Diagram[$Row]

    #Go through each cell
    For ($Col = 0; $Col -lt $CurrentRow.Length; $Col++) {
        $Adjacent = 0
        $Cell = $Diagram[$Row][$Col]

        #Skip if not a roll
        If ($Cell -ne '@') {
            continue
        }

        #Check for corners (Only has 3 adjacent cells)
        If (($Row -eq 0 -and $Col -eq 0) -or ($Row -eq $Diagram.Length - 1 -and $Col -eq $CurrentRow.Length - 1)) {
            $Accessible = $Accessible + 1
            continue
        }

        #Check the cells on the sides
        If ($Row -ne 0) {
            If ($Diagram[$Row - 1][$Col] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 
        If ($Row -ne $Diagram.Length - 1) {
            If ($Diagram[$Row + 1][$Col] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 

        If ($Col -ne 0) {
            If ($Diagram[$Row][$Col - 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        }
        If ($Col -ne $CurrentRow.Length - 1) {
            If ($Diagram[$Row][$Col + 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        }

        #Check the cells diagonal to it
        If ($Row -ne 0 -and $Col -ne 0) {
            If ($Diagram[$Row - 1][$Col - 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 
        If ($Row -ne $Diagram.Length - 1 -and $Col -ne 0) {
            If ($Diagram[$Row + 1][$Col - 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 
        If ($Row -ne 0 -and $Col -ne $CurrentRow.Length - 1) {
            If ($Diagram[$Row - 1][$Col + 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 
        If ($Row -ne $Diagram.Length - 1 -and $Col -ne $CurrentRow.Length - 1) {
            If ($Diagram[$Row + 1][$Col + 1] -eq '@') {
                $Adjacent = $Adjacent + 1
            }
        } 

        #Verify if it is accessible or not, accessible rolls will have less than 4 adjacent to it
        If ($Adjacent -lt 4) {
            $Accessible = $Accessible + 1
        }
    }
}

#Get the total amount accessible
Write-Host $Accessible #1518
