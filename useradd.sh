#!/bin/bash
echo "*************User Add Shell Script******************"
echo "List of users available:"
awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
echo "********************************************************"
read -p "Username:" username
# Creating User with the given input
useradd $username
# Setting password for the created user with the given input
passwd $username

# Enabling the PasswordAuthentication in the system so that user could login via PasswordAuthentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# Restarting the sshd service so that the config changes are reflected everywhere
systemctl restart sshd

# Checking sudoers file if an entry exist with the given username and saving the response in variable to process
v=$(grep -c "$username ALL=(ALL)NOPASSWD:ALL" /etc/sudoers)
echo "******************************************************"

if [ $v -eq 0 ]
then
   # If entry is not in the sudoers then asking the admin to give sudo access or not
   read -p "Do you want to give sudo access to the user $username ? (yes/no) :" rootaccess
   if [ "$rootaccess" = "yes" ]
   then
   echo "$username ALL=(ALL)NOPASSWD:ALL" | tee -a /etc/sudoers
   echo "Sudo access provided to $username"
   else
   echo "Sudo access is not provided to the $username"
   fi
else
   read -p "Sudo access already exist for user $username do you want to remove it ? (yes/no) :" revokeaccess
   if [ "$revokeaccess" = "yes" ]
   then
   # Revoking sudo access for the specified by removing the search string
   sed -i "s/$username ALL=(ALL)NOPASSWD:ALL//g" /etc/sudoers
   echo "Sudo access revoked from user $username"
   else
   echo "Sudo access provided to $username"
   fi
fi