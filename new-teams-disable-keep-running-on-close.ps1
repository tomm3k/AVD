#run this script as a startup script for each user

param(
# Close Teams App fully instead of running on Taskbar $true or $false
[boolean]$RunningOnClose=$False
)
# Get Teams Configuration
$FileContent=Get-Content -Path "$ENV:localAPPDATA\packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json"
# Convert file content from JSON format to PowerShell object
$JSONObject=ConvertFrom-Json -InputObject $FileContent
# Update Object settings
#$JSONObject.appPreferenceSettings.OpenAsHidden=$OpenAsHidden
$JSONObject.user_modified_auto_start=$user_modified_auto_start
$JSONObject.keep_app_running_on_close=$RunningOnClose
# Terminate Teams Process
Get-Process ms-Teams | Stop-Process -Force
# Convert Object back to JSON format
$NewFileContent=$JSONObject | ConvertTo-Json
# Update configuration in file
$NewFileContent | Set-Content -Path "$ENV:localAPPDATA\packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json"