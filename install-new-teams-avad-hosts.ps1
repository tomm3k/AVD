$sub = "ID"
$vm = "NAME"


Set-AzContext -SubscriptionName $sub

Write-Host "Install new teams"

$content = @()
$content += "mkdir C:\tempavd"
$content += "invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409' -OutFile 'C:\tempavd\teamsbootstrapper.exe'"
$content += "c:\tempavd\teamsbootstrapper.exe -p"
$content += "Remove-Item -LiteralPath 'c:\tempavd' -Force -Recurse -verbose"

Set-Content -Path .\teams.ps1 -Value $content

$teamsvm = get-azvm -name $vm -Verbose
$teamsvm | Invoke-AzVMRunCommand -CommandId "RunPowerShellScript" -ScriptPath .\teams.ps1 -Verbose

Write-Host "Installation successful"