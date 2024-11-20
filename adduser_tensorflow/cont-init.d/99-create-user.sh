#!/command/execlineb -P
/package/admin/s6-overlay/command/with-contenv bash -c "

# Access environment variables
USERNAME=\${USERNAME:-defaultuser}
PASSWORD=\${PASSWORD:-defaultpassword}
SHELL=\${SHELL:-/bin/bash}
useradd -m -s \${SHELL} \"\$USERNAME\"
echo \"\$USERNAME:\$PASSWORD\" | chpasswd

sudo usermod -aG sudo \${USERNAME}
sudo service ssh start

echo \"User \$USERNAME created with the provided password.\"
exec gosu \"${USERNAME}\" bash -c \"cd /home/\${USERNAME} && sleep infinity\"
# Exit script
exit 0
"