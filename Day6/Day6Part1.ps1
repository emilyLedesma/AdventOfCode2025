#Goal is to get the sum of the answers to a list of problems
$data = Get-Content .\Input.txt

#Splitting the set into the numbers and the operations signs
$numbers = $data[0..($data.Length - 2)]
$signs = $data[($data.Length - 1)].Split(' ') | Where-Object {$_ -ne ''}

#List to hold solutions
$solutions = @()

#Going through the numbers
for ($i = 0; $i -lt $numbers.Length; $i++) {
    #Getting all the numbers for the row
    $row = $numbers[$i].Split(' ') | Where-Object {$_ -ne ''}

    #Checking if the solutions list is empty
    if ($solutions.Count -eq 0) {
        #Setting it to the first number in the calculation
        $solutions = [long[]]$row
        continue
    }

    #Going through each number in the row
    for ($n = 0; $n -lt $row.Count; $n++) {
        #Getting the number and the operator
        $number = [long]$row[$n]
        $operator = $signs[$n]

        #Checking which operation to do and updating the solution list
        if ($operator -eq '+') {
            $solutions[$n] += [long]$number   
        }
        elseif ($operator -eq '*') {
            $solutions[$n] *= [long]$number  
        }
    }
}

#Returning the sum of the solutions
Write-Host ($solutions | Measure-Object -Sum).Sum