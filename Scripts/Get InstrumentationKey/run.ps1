$subscriptionId  =  "subscriptionId"
$aiKey = 'aiKey'

Login-AzureRmAccount -SubscriptionId $SubscriptionId 

Find-AzureRmResource -ResourceType "Microsoft.Insights/components" | ForEach-Object {Get-AzureRmResource -ResourceId $_.ResourceId} | Where-Object {$_.Properties.InstrumentationKey -match $aiKey } | ForEach-Object {$_.Name}

#Find-AzureRmResource -ResourceType "Microsoft.Insights/components" | %{Get-AzureRmResource -ResourceId $_.ResourceId} | %{$_.Name, $_.Properties.InstrumentationKey} 
