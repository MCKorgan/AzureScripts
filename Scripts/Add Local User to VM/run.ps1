$resourceGroupVM = "abb-mc-test-rg"
$virtualMachineName = "abb-mc-test-vm"
$scriptPath = "localrun.ps1"
$userName = "TestName666"
$password = "***REMOVED***"
$fullName = "Test Name"
$description = "Desc"
$groupName = "Administrators"

Invoke-AzureRmVMRunCommand -ResourceGroupName $resourceGroupVM -Name $virtualMachineName -CommandId 'RunPowerShellScript' -ScriptPath $scriptPath -Parameter @{"userName" = $userName;"password" = $password;"fullName" = $fullName;"description" = $description;"groupName" = $groupName} -Debug