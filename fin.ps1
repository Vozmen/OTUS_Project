Remove-Item "F:\1.IT\OTUS\project\exitcode.txt" -Force
$srv = 'web1', 'web2', 'promet', 'nginx', 'elk'
Write-Output $srv | foreach-Object {
    ssh $_ "echo OK"
} *>> "F:\1.IT\OTUS\project\exitcode.txt"

Select-String -Path "F:\1.IT\OTUS\project\exitcode.txt" -Pattern "OK" *> "F:\1.IT\OTUS\project\ok.txt"
$filename = "F:\1.IT\OTUS\project\ok.txt"
$exitcode = Get-Content $filename | ForEach-Object {
    $_.split(":")[3]} | Measure-Object
Remove-Item "F:\1.IT\OTUS\project\ok.txt"
if ( $exitcode.count -eq 5 )
{
Write-Host -Object "Connection to hosts Established" -BackgroundColor Green -ForegroundColor White
Start-Sleep -s 2
Write-Host -Object "Starting Installation" -BackgroundColor Green -ForegroundColor White
Start-Sleep -s 2
clear

ssh nginx "yum install wget -y"
ssh elk "yum install wget -y"

$srv = 'web1', 'web2', 'promet', 'nginx', 'elk'
$srv | foreach-Object -parallel{
    ssh $_ "sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/$_.sh -O /root/script && sudo chmod +x /root/script && sudo /root/script"
}
Write-Host -Object "INSTALLATION COMPLETE" -BackgroundColor Green -ForegroundColor White

}
else
{
clear
Write-Host -Object "INSTALLATION FAILED" -BackgroundColor Red -ForegroundColor White
}
