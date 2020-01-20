[xml]$xml = Get-Content .\serverdata.xml

foreach ($computer in $xml.computers.computer) { # Enumerating
    Write-Output " Computer $($computer.name)"
}

$node = $xml.SelectSingleNode("//computer[@name='ILCSDC1.critsol.net']") #Getting single value.
write " The node name is $($node.name)"
# find the first computer element with attribute name=""
#using xpath.



[xml]$xml = Get-Content .\serverdata.xml
foreach ($computer in $xml.computers.computer) {
    $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer.name
    $biosserial = $bios.serialnumber

    $computer.biosserial = [string]$biosserial
}
# $xml.InnerXml # Display Raw XML

$xml.Save(".\serverdata1.xml")