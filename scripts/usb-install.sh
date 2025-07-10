if ping -c 1 archlinux.org &> /dev/null; then
  echo "✅ Internet is available."
else
  echo "❌ No internet connection."
  iwctl station wlan0 get-networks
  echo "Input name of network: "
  read $name
  echo "Password: "
  read $password
  iwctl station wlan0 connect $name -P $password
fi



