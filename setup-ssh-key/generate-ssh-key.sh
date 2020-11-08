if [ ! -f "/home/$(logname)/.ssh/id_rsa.pub" ]; then
  echo "Generating ssh public key."
  sudo -u "$(logname)" ssh-keygen -t rsa -q -f "/home/$(logname)/.ssh/id_rsa" -N ""
else
  echo "Ssh public key already exists."
fi
