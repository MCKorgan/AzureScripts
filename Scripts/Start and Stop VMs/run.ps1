Param 
(    
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
    [String] 
    $SubscriptionId, 
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
    [String] 
    $VirtualMachinesList = "ALL", 
    [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()] 
    [String] 
    $VirtualMachinesListToNotChange = "NONE", 
    [Parameter(Mandatory=$true)][ValidateSet("Start","Stop")] 
    [String] 
    $Action,
    [Parameter(Mandatory=$false)][ValidateSet("Y","N")] 
    [String] 
    $CheckTags = 'Y',
    [Parameter(Mandatory=$false)]
    [String] 
    $ToNotChangeTag = 'ToNotRestart',
    [Parameter(Mandatory=$false)]
    [String] 
    $TagName = '01_dplynam'
) 

Connect-AzureRMAccount
Select-AzureRmSubscription -SubscriptionId $SubscriptionId

if($VirtualMachinesListToNotChange -ne "NONE")
{
    [System.Collections.ArrayList]$VirtualMachinesToNotChange = @($VirtualMachinesListToNotChange.Split(","))
}

if($VirtualMachinesList -eq "ALL") 
{ 
    [System.Collections.ArrayList]$AzureVMsToCheck = @((Get-AzureRmVM).Name | Where-Object {$VirtualMachinesToNotChange -notcontains $_})
} 
else 
{ 
    [System.Collections.ArrayList]$splittedVMs = @($VirtualMachinesList.Split(","))
    [System.Collections.ArrayList]$AzureVMsToCheck = @($splittedVMs | Where-Object {$VirtualMachinesToNotChange -notcontains $_})
} 

$AzureVMsToHandle = New-Object System.Collections.ArrayList

foreach ($vmName in $AzureVMsToCheck) 
{
    $vm = Get-AzureRmVM | Where-Object {$_.Name -eq $vmName} | Select-Object Name, ResourceGroupName -First 1

    if(!$vm) 
    { 
        throw "AzureVM : [$AzureVM] - Does not exist! - Check your inputs" 
    } 

    if($CheckTags -eq "Y")
    {
        $tags = (Get-AzureRmResource -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name).Tags.GetEnumerator()
        $filteredTags = $tags | Where-Object -FilterScript {$_.Key -eq $TagName -and $_.Value -match $ToNotChangeTag}

        if(!$filteredTags)
        {
            [void]$AzureVMsToHandle.Add($vmName)
        }
    }
    else
    {
        [void]$AzureVMsToHandle.Add($vmName)
    }
}

if($Action -eq "Stop") 
{ 
    Write-Output "Stopping VMs"; 
    foreach ($AzureVM in $AzureVMsToHandle) 
    { 
        Write-Output $AzureVM
        Get-AzureRmVM | Where-Object {$_.Name -eq $AzureVM} | Stop-AzureRmVM -Force 
    } 
} 
else 
{ 
    Write-Output "Starting VMs"; 
    foreach ($AzureVM in $AzureVMsToHandle) 
    { 
        Write-Output $AzureVM
        Get-AzureRmVM | Where-Object {$_.Name -eq $AzureVM} | Start-AzureRmVM 
    } 
} 