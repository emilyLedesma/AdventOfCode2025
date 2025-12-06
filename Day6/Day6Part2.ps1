#Goal is to get the sum of the answers to a list of problems with a vertical number orientation
$data = Get-Content -Path .\Input.txt

#Splitting the set into the numbers and the operations signs
$numbers = $data[0..($data.Length - 2)]
$signs = $data[($data.Length - 1)].Split(' ') | Where-Object {$_ -ne ''}

#List to hold solutions and variable for the index of the current problem
$solutions = @()
$problem = 0

#Iterating through each column in the row
for ($i = 0; $i -lt $numbers[0].Length; $i++) {
    #Getting the number and the operator
    $vertical = -join (($numbers | ForEach-Object {$_[$i]}) | Where-Object {$_ -ne ' '})
    $operator = $signs[$problem]

    #Checking if the solution is empty for this problem
    if ($solutions[$problem] -eq $null -and $vertical -ne '') {
        $solutions += @([long]$vertical)
    } 
    #Checking if the problem is finished
    elseif ($vertical -eq '') {
        $problem += 1
    }
    #Checking which operation to do and updating the solution
    elseif ($operator -eq '+') {
        $solutions[$problem] += [long]$vertical   
    }
    elseif ($operator -eq '*') {
        $solutions[$problem] *= [long]$vertical  
    }
}

#Returning the sum of the solutions
Write-Host ($solutions | Measure-Object -Sum).Sum