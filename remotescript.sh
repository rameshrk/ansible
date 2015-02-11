printf "\n=================== %s : %s ===============\n" `hostname`  `hostname -i`
echo Hostname : `hostname`
echo IP Address: `hostname -i`
echo 

echo CPUs: `nproc`

free -m | awk 'NR==2{printf "Memory Usage: %s/%sGB (%.2f%%)\n", $3/1000,$2/1000,$3*100/$2 }'
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'
echo OS  `lsb_release -a | grep "Linux"`

printf "Disk usage\n"
df -h | grep "/data" |awk '"/"{printf "/data: Size:%s Used:%s Avail:%s\n", $1,$2,$3}'
df -h | grep "/logs" |awk '"/"{printf "/logs: Size:%s Used:%s Avail:%s\n", $1,$2,$3}'


printf "\nJava Processes:\n"
ps axuwww | grep java | grep -v grep | awk 'NF>1{print $NF}'

printf "\nEnvironment Variables:\n"
printenv | less| grep "CASSANDRA|JAVA"

printf "\nPermissions:\n"
ls -lrt / | grep "data\|logs" | awk '"/"{printf "%s %s %s %s\n", $1,$3,$4,$9}'
echo ---------------------------------------------------
printf "\n\n"

