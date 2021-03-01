$table = Get-AzResourceGroup | select ResourceGroupName
for ($i=0;$i -le $table.Rows.Count;$i++)
{
 Remove-AzResourceGroup "$($table.ResourceGroupName[$i])"
}