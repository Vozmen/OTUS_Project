ssh nginx "yum install wget -y"
ssh elk "yum install wget -y"

$srv = 'web1', 'web2', 'promet', 'nginx', 'elk'
$srv | foreach-Object -parallel{
    ssh $_ "sudo wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/$_.sh -O /root/script && sudo chmod +x /root/script && sudo /root/script"
} &"
