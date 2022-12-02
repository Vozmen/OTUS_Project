Remove-Item "F:\1.IT\OTUS\project\exitcode.txt" -ErrorAction SilentlyContinue
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

Write-Host "=" -ForegroundColor Green -BackgroundColor Black -noNewline
Write-Host -Object "CONNECTION TO HOSTS ESTABLISHED" -BackgroundColor Green -ForegroundColor White -noNewline
Write-Host "=" -ForegroundColor Green -BackgroundColor Black 
Start-Sleep -s 2
Write-Host "======" -ForegroundColor Green -BackgroundColor Black -noNewline
Write-Host -Object "STARTING INSTALLATION" -BackgroundColor Green -ForegroundColor White -noNewline
Write-Host "======" -ForegroundColor Green -BackgroundColor Black
Start-Sleep -s 2
Clear-Host

$srv = 'web1', 'web2'
$srv | foreach-Object -parallel{
    ssh $_ "sudo apt install -y php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-zip php-xml unzip cifs-utils nfs-common mysql-server"
}

$srv = 'elk', 'nginx'
$srv | foreach-Object -parallel{
    ssh $_ "yum install -y wget epel-release & systemctl disable --now firewalld"
}

ssh elk "yum install -y net-tools java-openjdk-devel java-openjdk"

Write-Host "======" -ForegroundColor Green -BackgroundColor Black -noNewline
Write-Host -Object "SOFTWARE PREINSTALLED" -BackgroundColor Green -ForegroundColor White -noNewline
Write-Host "======" -ForegroundColor Green -BackgroundColor Black

$srv = 'web1', 'web2', 'promet', 'nginx', 'elk'
$srv | foreach-Object -parallel{
    ssh $_ "sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/$_.sh -O /root/script && sudo chmod +x /root/script && sudo /root/script"
}
Write-Host "======" -ForegroundColor Green -noNewline
Write-Host "INSTALLATION COMPLETE" -BackgroundColor Green -ForegroundColor White -noNewline
Write-Host "======" -ForegroundColor Green 

}
else
{
Clear-Host
Write-Host "======" -ForegroundColor Red -noNewline
Write-Host -Object "INSTALLATION FAILED" -BackgroundColor Red -ForegroundColor White -noNewline
Write-Host "======" -ForegroundColor Red
}