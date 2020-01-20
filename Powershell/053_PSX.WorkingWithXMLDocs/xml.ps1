function Update-XMLInventoryData {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$InputFilePath,

        [Parameter(
            Mandatory=$true
        )]
        [string]$OutputFilePath
    )

    [xml]$xml = Get-Content $InputFilePath

    foreach ($computer in $xml.computers.computer) {
        # Query Information
        $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer.name
        $sys = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer.name
        $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer.name

        # update xml
        # add value to xml element
        $computer.biosserial = [string]$bios.serialnumber

        # create new node for mfgr.
        $new_node = $xml.CreateNode("element","manufacturer","")
        $new_node.InnerText = $sys.manufacturer
        $computer.AppendChild($new_node) | Out-Null

        # create new attr for build
        $new_attr = $xml.CreateAttribute('build')
        $new_attr.value = $os.buildnumber
        $computer.SetAttributeNode($new_attr) | Out-Null
    }


$xml.save($OutputFilePath)
}

Update-XMLInventoryData -InputFilePath C:\Users\driosx.CRIT\documents\XML\serverdata.xml -OutputFilePath C:\Users\driosx.CRIT\documents\XML\serverdata2.xml
