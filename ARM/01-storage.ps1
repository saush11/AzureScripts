$resgrpname = Get-Random
$storagename = Get-Random
accountType
kind
accessTier
minimumTlsVersion
supportsHttpsTrafficOnly
allowBlobPublicAccess
AllowSharedKeyAccess
networkAclsBypass
networkAclsDefaultAction


New-AzResourceGroup -Name $resgrpname -Location northeurope -Force

New-AzResourceGroupDeployment -storageAccountName $storagename -ResourceGroupName $resgrpname -accounType  -TemplateFile '01-storage.json'