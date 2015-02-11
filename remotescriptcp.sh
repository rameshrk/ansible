printf "\n=================== %s : %s ===============\n" `hostname`  `hostname -i` > ouput.txt
echo Hostname : `hostname` >> outputcp.txt
echo IP Address: `hostname -i`>> outputcp.txt
echo >> outputcp.txt

echo CPUs: `nproc`>> outputcp.txt

free -m | awk 'NR==4{printf "Memory Usage: %s/%sGB (%.2f%%)\n", $3/1000,$2/1000,$3*100/$2 }'>> outputcp.txt
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'>> outputcp.txt
echo OS  `lsb_release -a | grep "Linux"`>> outputcp.txt

printf "Disk usage\n">> outputcp.txt
df -h | grep "/data" |awk '"/"{printf "/data: Size:%s Used:%s Avail:%s\n", $1,$2,$3}'>> outputcp.txt
df -h | grep "/logs" |awk '"/"{printf "/logs: Size:%s Used:%s Avail:%s\n", $1,$2,$3}'>> outputcp.txt


printf "\nJava Processes:\n">> outputcp.txt
ps axuwww | grep java | grep -v grep | awk 'NF>1{print $NF}'>> outputcp.txt

printf "\nEnvironment Variables:\n">> outputcp.txt
printenv | less| grep "CASSANDRA|JAVA">> outputcp.txt

printf "\nPermissions:\n">> outputcp.txt
ls -lrt / | grep "data\|logs" | awk '"/"{printf "%s %s %s %s\n", $1,$3,$4,$9}'>> outputcp.txt
echo --------------------------------------------------->> outputcp.txt
printf "\n\n">> outputcp.txt

