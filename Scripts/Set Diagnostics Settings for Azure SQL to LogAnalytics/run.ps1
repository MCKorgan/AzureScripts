$subscriptionId = "subscriptionId"
$databaseName = "*DatabaseName"
$resourceGroupName = "rg"
$logAnalyticsName = "loganalyticsname"

$workspaceId = "/subscriptions/$($subscriptionId)/resourceGroups/$($resourceGroupName)/providers/Microsoft.OperationalInsights/workspaces/$($logAnalyticsName)"

Get-AzureRmResource -ResourceType "Microsoft.Sql/servers/databases" -ResourceGroupName $resourceGroupName | Where-Object ResourceId -Like $databaseName | Select-Object -Property ResourceId  | ForEach-Object {$_}
# Set-AzureRmDiagnosticSetting -ResourceId /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Sql/servers/dbservername/databases/DatabaseName -WorkspaceId $workspaceId -Enabled $true

Get-AzureRmResource -ResourceType "Microsoft.Sql/servers/databases" -ResourceGroupName $resourceGroupName | Where-Object ResourceId -Like $databaseName | Select-Object -Property ResourceId | ForEach-Object {Set-AzureRmDiagnosticSetting -ResourceId $_.ResourceId -WorkspaceId $workspaceId -Enabled $true}