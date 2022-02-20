#decline x86, Itanium, ARM64, and Previews
Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*x86*' -or $_.Update.Title -like '*Itanium*' -or $_.Update.Title -like '*ARM64*' -or $_.Update.Title -like '*Preview*'} | Deny-WsusUpdate

#decline all non-English updates
#Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*ar-sa*' -or $_.Update.Title -like '*bg-bg*' -or $_.Update.Title -like '*cs-cz*' -or $_.Update.Title -like '*da-dk*' -or $_.Update.Title -like '*de-de*' -or $_.Update.Title -like '*el-gr*' -or $_.Update.Title -like '*en-gb*' -or $_.Update.Title -like '*es-es*' -or $_.Update.Title -like '*es-mx*' -or $_.Update.Title -like '*et-ee*' -or $_.Update.Title -like '*fi-fi*' -or $_.Update.Title -like '*fr-ca*' -or $_.Update.Title -like '*fr-fr*' -or $_.Update.Title -like '*he-il*' -or $_.Update.Title -like '*hr-hr*' -or $_.Update.Title -like '*hu-hu*' -or $_.Update.Title -like '*it-it*' -or $_.Update.Title -like '*ja-jp*' -or $_.Update.Title -like '*ko-kr*' -or $_.Update.Title -like '*lt-lt*' -or $_.Update.Title -like '*lv-lv*' -or $_.Update.Title -like '*nb-no*' -or $_.Update.Title -like '*nl-nl*' -or $_.Update.Title -like '*pl-pl*' -or $_.Update.Title -like '*pt-br*' -or $_.Update.Title -like '*pt-pt*' -or $_.Update.Title -like '*ro-ro*' -or $_.Update.Title -like '*ru-ru*' -or $_.Update.Title -like '*sk-sk*' -or $_.Update.Title -like '*sl-si*' -or $_.Update.Title -like '*sr-latn-rs*' -or $_.Update.Title -like '*sv-se*' -or $_.Update.Title -like '*th-th*' -or $_.Update.Title -like '*tr-tr*' -or $_.Update.Title -like '*uk-ua*' -or $_.Update.Title -like '*zh-cn*' -or $_.Update.Title -like '*zh-hk*' -or $_.Update.Title -like '*zh-tw*'} | Deny-WsusUpdate

#decline Edge Dev and Beta
Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*Microsoft Edge-Beta*' -or $_.Update.Title -like '*Microsoft Edge-Dev*'} | Deny-WsusUpdate

#decline consumer editions
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*consumer editions*'} | Deny-WsusUpdate

#Decline Superseeded WSUS Updates
Get-WSUSUpdate -Classification All -Status Any -Approval AnyExceptDeclined `
    | Where-Object { $_.Update.GetRelatedUpdates(([Microsoft.UpdateServices.Administration.UpdateRelationship]::UpdatesThatSupersedeThisUpdate)).Count -gt 0 } `
    | Deny-WsusUpdate

#Cleanup obsolete computers and obsolete updates
Invoke-WsusServerCleanup -CleanupObsoleteComputers -CleanupObsoleteUpdates

#Accept virusscanner updates and edge updates and powershell and .Net for all
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Antivirus*' -or $_.Update.Title -like '*Microsoft Edge*'-or $_.Update.Title -like '*Edge-Stable*' -or $_.Update.Title -like '*PowerShell*' -or $_.Update.Title -like '*.NET*'} | Approve-WsusUpdate -Action Install -TargetGroupName "All Computers"

#Accept 365 updates and Windows 11 for WS
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Microsoft 365*' -or $_.Update.Title -like '*Office*' -or $_.Update.Title -like '*Office 365*' -or $_.Update.Title -like '*Windows 11*'} | Approve-WsusUpdate -Action Install -TargetGroupName "WS" 

#Accept version 21H2 for Servers
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*version 21H2*' -or $_.Update.Title -like '*Microsoft server operating system version 21H2*'} | Approve-WsusUpdate -Action Install -TargetGroupName "Servers"
