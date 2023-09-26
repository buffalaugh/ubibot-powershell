$token=""
$uriofyourchannel=""
$uriofyourinfluxdb=""
$location=""

#We get the temperature value by storing a web request on a variable
$Temp=Invoke-WebRequest -Method Get -Uri $uriofyourchannel | ConvertFrom-Json | Select-Object -ExpandProperty  channel| Select-Object -ExpandProperty last_values| ConvertFrom-Json | Select-Object -ExpandProperty  field1 | Select-Object -ExpandProperty  value

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Token $token")
$headers.Add("Content-Type", "text/plain")

$body = "Temp,location= temperature=$temp"

$response = Invoke-RestMethod $uriofyourinfluxdb -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json