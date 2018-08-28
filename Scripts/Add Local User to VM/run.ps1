$resourceGroupVM = "rgVM"
$virtualMachineName = "vmName"
$scriptPath = "localrun.ps1"
$userName = "usName"
$password = "password"
$fullName = "Test Name"
$description = "Desc"
$groupName = "Group"

Invoke-AzureRmVMRunCommand -ResourceGroupName $resourceGroupVM -Name $virtualMachineName -CommandId 'RunPowerShellScript' -ScriptPath $scriptPath -Parameter @{"userName" = $userName;"password" = $password;"fullName" = $fullName;"description" = $description;"groupName" = $groupName}