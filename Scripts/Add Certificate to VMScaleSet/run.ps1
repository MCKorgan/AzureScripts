$keyvaultName = "keyvaultname"
$resourceGroup = "rg"
$secretName = "secretName"
$vmName = "vmname"
$certificationStore = "My"

$certURL = (Get-AzureKeyVaultSecret -VaultName $keyvaultName -Name $secretName).id

$vm = Get-AzureRmVM -ResourceGroupName $resourceGroup -Name $vmName
$vaultId = (Get-AzureRmKeyVault -ResourceGroupName $resourceGroup -VaultName $keyVaultName).ResourceId
$vm = Add-AzureRmVMSecret -VM $vm -SourceVaultId $vaultId -CertificateStore $certificationStore -CertificateUrl $certURL

Update-AzureRmVM -ResourceGroupName $resourceGroup -VM $vm