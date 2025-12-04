#Goal is to get the sum of the max joltage of the rows
#Get the sum of the max 2 digit number in the order they appear in the row for each row
#Setting the input path to the input file 
$InputPath = $PSScriptRoot + '.\Input.txt'

#Variable to store the amount of accessible rolls
$Accessible = 0

#Parsing the input into the row list
$Input = Get-Content -Path $InputPath
$Diagram = [string[]]$Input -split ' '

$HasAccessible = $true

While ($HasAccessible) {
    For ($Row = 0; $Row -lt $Diagram.Length; $Row++) {
        $CurrentRow = $Diagram[$Row]
        $Accessed = @{}

        For ($Col = 0; $Col -lt $CurrentRow.Length; $Col++) {
            $Adjacent = 0
            $Cell = $Diagram[$Row][$Col]

            If ($Cell -ne '@') {
                continue
            }

            #Check for corners (Only has 3 adjacent cells)
            If (($Row -eq 0 -and $Col -eq 0) -or ($Row -eq $Diagram.Length - 1 -and $Col -eq $CurrentRow.Length - 1)) {
                $Accessible = $Accessible + 1
                continue
            }

            If ($Row -ne 0) {
                If ($Diagram[$Row - 1][$Col] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row - 1] = $Col
                }
            } 
            If ($Row -ne $Diagram.Length - 1) {
                If ($Diagram[$Row + 1][$Col] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row + 1] = $Col
                }
            } 

            If ($Col -ne 0) {
                If ($Diagram[$Row][$Col - 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row] = $Col - 1
                }
            }
            If ($Col -ne $CurrentRow.Length - 1) {
                If ($Diagram[$Row][$Col + 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row] = $Col + 1
                }
            }

            If ($Row -ne 0 -and $Col -ne 0) {
                If ($Diagram[$Row - 1][$Col - 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row - 1] = $Col - 1
                }
            } 
            If ($Row -ne $Diagram.Length - 1 -and $Col -ne 0) {
                If ($Diagram[$Row + 1][$Col - 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row + 1] = $Col - 1
                }
            } 
            If ($Row -ne 0 -and $Col -ne $CurrentRow.Length - 1) {
                If ($Diagram[$Row - 1][$Col + 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row - 1] = $Col + 1
                }
            } 
            If ($Row -ne $Diagram.Length - 1 -and $Col -ne $CurrentRow.Length - 1) {
                If ($Diagram[$Row + 1][$Col + 1] -eq '@') {
                    $Adjacent = $Adjacent + 1
                    $Accessed[$Row + 1] = $Col + 1
                }
            } 

            #Write-Host $Adjacent $Row,$Col
            If ($Adjacent -lt 4) {
                $Accessible = $Accessible + 1
            }
        }
    }

    If ($Accessible = 0) {
        $HasAccessible = $false
    }

    Foreach ($Hash in $Accessed.GetEnumerator()) {
        $Diagram[[int]$Hash.Key][[int]$Hash.Value] = 'X' #Unable to index
    }
}

Write-Host $Accessible