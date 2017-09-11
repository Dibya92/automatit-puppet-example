#!/usr/bin/env bash

echo 'Provisioning r10k'

set -e

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

case "$(hostname -s)" in
  puppet-master) DEPS=(ruby ruby-dev git) && GEM_DEPS=(r10k) ;;
  puppet-agent) DEPS=(git) ;;
  *) echo "Unexpected hostname: $(hostname -s). Exiting" && exit 1 ;;
esac

function install_sys_dependencies() {
  echo "Installing deps"
  for pack in ${DEPS[@]}
  do
    apt-get -y install "$pack" > /dev/null 2>&1
  done
}

function install_gem_dependencies() {
  echo "Installing gems"
  for g in ${GEM_DEPS[@]}
  do
    gem install "$g" --no-ri --no-rdoc > /dev/null 2>&1
  done
}

function install_puppet_modules() {
  echo "Installing puppet modules"
  cd /vagrant && r10k puppetfile install
}

# Execute
for pack in ${DEPS[@]}
do
  dpkg-query -l $(echo "$pack") > /dev/null 2>&1
  ec=$?
  if [ "$ec" != 0 ]
  then
    install_sys_dependencies
  fi
done

for g in ${GEM_DEPS[@]}
do
  gem list -i $(echo "$g") > /dev/null 2>&1
  ec=$?
  if [ "$ec" != 0 ]
  then
    install_gem_dependencies
  fi
done

install_puppet_modules
