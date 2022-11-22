ssh cloud1 "
wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/cloud1.sh -O /home/cloud1/cl1 /
wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/cloud2.sh -O /home/cloud1/cl2 /
wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/nginx.sh -O /home/cloud1/nginx /
wget https://raw.githubusercontent.com/Vozmen/OTUS_Project/main/promet.sh -O /home/cloud1/prom /
chmod +x /home/cloud1/cl1 /home/cloud1/cl2 /home/cloud1/nginx /home/cloud1/prom
ssh cloud2@cloud2 'bash -s' < cl2 & /
sleep 1 /
ssh root@nginx 'bash -s' < nginx & /
sleep 1 /
ssh promet@promet 'bash -s' < prom & /
sleep 1 /
/home/cloud1/cl1 &"