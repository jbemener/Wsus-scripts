## Jelle Bemener ##
## WSUS Accept Lines ##

#Accept virusscanner updates and edge updates and powershell and .Net for all
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Antivirus*' -or $_.Update.Title -like '*Microsoft Edge*'-or $_.Update.Title -like '*Edge-Stable*' -or $_.Update.Title -like '*PowerShell*' -or $_.Update.Title -like '*.NET*'} | Approve-WsusUpdate -Action Install -TargetGroupName "All Computers"

#Accept 365 updates and Windows 11 for WS
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Microsoft 365*' -or $_.Update.Title -like '*Office*' -or $_.Update.Title -like '*Office 365*' -or $_.Update.Title -like '*Windows 11*'} | Approve-WsusUpdate -Action Install -TargetGroupName "WS" 

#Accept version 21H2 for Servers
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*version 21H2*' -or $_.Update.Title -like '*Microsoft server operating system version 21H2*'} | Approve-WsusUpdate -Action Install -TargetGroupName "Servers"
