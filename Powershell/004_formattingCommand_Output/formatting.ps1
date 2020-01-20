# More Attractive

Get-Process | Format-Wide
<#
ApplicationFrameHost                                                                                          audiodg
browser_broker                                                                                                chrome
chrome                                                                                                        chrome
chrome                                                                                                        chrome
chrome                                                                                                        chrome                                                                                                       
chrome                                                                                                        chrome
chrome                                                                                                        chrome
chrome                                                                                                        chrome
chrome                                                                                                        chrome
chrome                                                                                                        Code
Code                                                                                                          Code
#>

Get-Process | Format-Wide -Property Id #only one property

<#
9316                                                                                                          5860
5032                                                                                                          1044
2440                                                                                                          3592
3956                                                                                                          5844
5852                                                                                                          6396 
#>

Get-Process | Format-Wide -Property Id -AutoSize

Get-Process | Format-List -Property 
Get-Process | fl *
Get-Process notepad | fl *

Get-Process | ft
Get-Process | ft -Property Name,VM,PM,CPU,Id -AutoSize -Wrap

Get-Service | sort status | Format-Table -GroupBy Status -Property Name,Status,DisplayName

Get-Process | Format-Table -Property Name,Id,@{ n='VM(MB)'; e={ $_.VM / 1MB -as [int] }}, @{n='PM(MB)';e={$_.PM / 1MB -as [int] } } -AutoSize

Get-Process | Format-Table -Property Name,Id,@{ n='VM(MB)'; e={ $_.VM / 1MB -as [int] }; 'formatstring'='N2';'align'='right'; width=12 },`
@{ n='PM(MB)'; e={$_.PM / 1MB -as [int] }; 'formatstring'='N2'; 'align'='right'; width=10 } -AutoSize | gm #ConvertTo-Html | Out-File processes.html 

# 4 commands with output. OUt-host, out-file, out-printer, out-string 

# Format Right....as far to the right of the command as possible. 

Get-Process | Select-Object -Property Name,Id,@{ n='VM(MB)'; e={ $_.VM / 1MB -as [int] }},@{ n='PM(MB)'; e={$_.PM / 1MB -as [int] }} | gm 


