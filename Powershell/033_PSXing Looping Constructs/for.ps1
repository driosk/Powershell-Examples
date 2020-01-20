$array1 = "one","two","three","four","five"
$array2 = "fred","barney","wilma","betty","pebbles"
$string = "One day we saw two eating four"

for ([int]$x = 0; $x -lt $array1.Count; $x++) {
    echo "Loop $x"
    $string = $string -replace $array1[$x],$array2[$x]
}                             # one,   fred for loop 1

$string
<#
for ($i = 0; $i -lt $array.Count; $i++) {
      starting condition;as long as this is true ;After loop completes each time
}
#>

$array1 = "criticalsolutions.net", "gmail.com", "company.com"
$array2 = "criticalsolutions.net", "outlook.com", "company.pri"

$emails = 'don@criticalsolutions.net',
'joe@gmail.com',
'fred@company.com'
foreach ($email in $emails) {
    for ($x = 0; $x -lt $array1.Count; $x++) {
        $email = $email -replace $array1[$x], $array2[$x]
    }
    Write-Output $email
} # refering to both arrays by index at the same time.
# enumerate something a specific number of times and know what count you are on.

$existing = 'SERVER1', 'SERVER3', 'SERVER4', 'SERVER7'

$candidate = 0
do {
    $candidate++
    $possiblename = "SERVER$candidate"

} while ($existing.Contains($possiblename))
#While this is tru
$possiblename

$this = 5
$that = 7
while ($this -eq $that) {
    #only executes while this is true to begin with
    write "Hello"
    $that++
}
$this = 0
$that = 5
do {
    # keep executing Until this is true
    write $this
    $this++
} until ($this -eq $that)