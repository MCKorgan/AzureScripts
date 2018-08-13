$keyvaultName = "kvName"
$resourceGroupVM = "rgVM"
$resourceGroupKV = "rgKV"
$secretName = "secretName"
$vmName = "VMName"
$certificationStore = "Root"

$certURL = (Get-AzureKeyVaultSecret -VaultName $keyvaultName -Name $secretName).id

$vm = Get-AzureRmVM -ResourceGroupName $resourceGroupVM -Name $vmName
$vaultId = (Get-AzureRmKeyVault -ResourceGroupName $resourceGroupKV -VaultName $keyVaultName).ResourceId
$vm = Add-AzureRmVMSecret -VM $vm -SourceVaultId $vaultId -CertificateStore $certificationStore -CertificateUrl $certURL

Update-AzureRmVM -ResourceGroupName $resourceGroupVM -VM $vm