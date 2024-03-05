machine_name=$(hostnamectl | grep Static | cut -d' ' -f4)
echo "Machine name: ${machine_name}"

source /etc/os-release
kernel_version=$(uname -r)
echo "OS ${PRETTY_NAME} and kernel version is ${kernel_version}"

ip_name=$(ip a | grep '2:' -A 2 | grep inet | tr -s ' ' | cut -d' ' -f3)
echo "ip: ${ip_name}"

ram_total=$(free | grep 'Mem' | tr -s ' ' | cut -d' ' -f2)
ram_free=$(free | grep 'Mem' | tr -s ' ' | cut -d' ' -f4)
echo "RAM: ${ram_total} memory available on ${ram_free} total memory "

disk_avaible=$(df | grep '/dev/mapper/rl-root' | tr -s ' ' | cut -d' ' -f4)
echo "Disk : ${disk_avaible} space left"

echo "Top 5 processes by RAM usage :"
while read process; do
  top5_process=$(cut -d' ' -f1 <<< "$process" | cut -d'/' -f4)
  echo "  - $top5_process"
done <<< "$(ps -eo cmd= --sort=-%mem | head -n5)" 

echo "Listening ports :"
while read ports; do
  proto=$(echo $ports | cut -d' ' -f1)
  port=$(echo $ports | cut -d' ' -f5| cut -d':' -f2)
  programme=$(echo $ports | cut -d' ' -f7|cut -d'"' -f2 )
  echo $port $proto : $programme
done <<< "$(sudo ss -lnptu4H)" 

echo "PATH directories :"
old_ifs="${IFS}"
IFS=':'
for dir in $PATH
do
echo "- $dir"
done
IFS="${old_ifs}"


random_cat=$(curl -s 'https://api.thecatapi.com/v1/images/search?limit=10' | grep  "url" | cut -d '"' -f8)
echo "Here is your random cat (jpg file): $random_cat"


