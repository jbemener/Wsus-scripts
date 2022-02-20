#decline x86, Itanium, ARM64, and Previews
Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*x86*' -or $_.Update.Title -like '*Itanium*' -or $_.Update.Title -like '*ARM64*' -or $_.Update.Title -like '*Preview*'} | Deny-WsusUpdate
#decline all non-English updates
Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*ar-sa*' -or $_.Update.Title -like '*bg-bg*' -or $_.Update.Title -like '*cs-cz*' -or $_.Update.Title -like '*da-dk*' -or $_.Update.Title -like '*de-de*' -or $_.Update.Title -like '*el-gr*' -or $_.Update.Title -like '*en-gb*' -or $_.Update.Title -like '*es-es*' -or $_.Update.Title -like '*es-mx*' -or $_.Update.Title -like '*et-ee*' -or $_.Update.Title -like '*fi-fi*' -or $_.Update.Title -like '*fr-ca*' -or $_.Update.Title -like '*fr-fr*' -or $_.Update.Title -like '*he-il*' -or $_.Update.Title -like '*hr-hr*' -or $_.Update.Title -like '*hu-hu*' -or $_.Update.Title -like '*it-it*' -or $_.Update.Title -like '*ja-jp*' -or $_.Update.Title -like '*ko-kr*' -or $_.Update.Title -like '*lt-lt*' -or $_.Update.Title -like '*lv-lv*' -or $_.Update.Title -like '*nb-no*' -or $_.Update.Title -like '*nl-nl*' -or $_.Update.Title -like '*pl-pl*' -or $_.Update.Title -like '*pt-br*' -or $_.Update.Title -like '*pt-pt*' -or $_.Update.Title -like '*ro-ro*' -or $_.Update.Title -like '*ru-ru*' -or $_.Update.Title -like '*sk-sk*' -or $_.Update.Title -like '*sl-si*' -or $_.Update.Title -like '*sr-latn-rs*' -or $_.Update.Title -like '*sv-se*' -or $_.Update.Title -like '*th-th*' -or $_.Update.Title -like '*tr-tr*' -or $_.Update.Title -like '*uk-ua*' -or $_.Update.Title -like '*zh-cn*' -or $_.Update.Title -like '*zh-hk*' -or $_.Update.Title -like '*zh-tw*'} | Deny-WsusUpdate
#decline Edge Dev and Beta
Get-WsusUpdate -Approval UnApproved | Where{$_.Update.Title -like '*Microsoft Edge-Beta*' -or $_.Update.Title -like '*Microsoft Edge-Dev*'} | Deny-WsusUpdate
#decline Windows 10
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Windows 10*'} | Deny-WsusUpdate
#decline consumer version
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*consumer*'} | Deny-WsusUpdate

#Approve Windows 11 updates to client computer targetgroup
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Windows 11*'} | Approve-WsusUpdate -Action Install -TargetGroupName "clients"
#Approve Windows Server 2022 to server computer targetgroup
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*version 21H2*'} | Approve-WsusUpdate -Action Install -TargetGroupName "servers"
#Approve Edge and Security to All Computer
Get-WsusUpdate -Approval Unapproved | Where{$_.Update.Title -like '*Microsoft Edge*' -or $_.Update.title -like '*Security Intelligence*' -or $_.Update.Title -like '*Microsoft Defender*' -or $_.Update.Title -like '*Windows Defender*'} | Approve-WsusUpdate -Action Install -TargetGroupName "All Computers"  



