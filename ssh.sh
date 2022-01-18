#!/usr/bin/env bash

mkdir -p ~/.ssh

if ls -al ~/.ssh | grep id_rsa >/dev/null; then
  echo "SSH keys appear to exist. Do nothing."
  exit 0
fi

ssh-keygen -t rsa -b 4096 -C "david@formbound.com"

eval "$(ssh-agent -s)"

cat <<EOT >>~/.ssh/config
Host *
   AddKeysToAgent yes
   UseKeychain yes
   IdentityFile ~/.ssh/id_rsa
EOT

ssh-add -K ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
