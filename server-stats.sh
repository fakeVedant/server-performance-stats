echo "***** OS Version *****"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo

echo "***** Uptime *****"
uptime
echo

echo "***** Load Average *****"
uptime | awk -F'load average:' '{print $2}'
echo

echo "***** LoggedIn User *****"
whoami
echo

echo "***** Failed Password Attempts *****"
journalctl _COMM=sshd | grep "Failed password"
echo

echo "***** Total CPU Usages *****"
top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'
echo

echo "***** Total memory usage (Free vs Used including percentage) *****"
free | grep "Mem:" -w | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
echo

echo "***** Total disk usage (Free vs Used including percentage) *****"
df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
echo

echo "***** Top 5 processes by CPU usage *****"
ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
echo

echo "***** Top 5 processes by memory usage *****"
ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
echo
