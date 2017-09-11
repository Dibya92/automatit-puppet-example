#!/usr/bin/env bash

echo 'Provisioning master/agent'

# # Check for root permissions
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Puppet Master/Agent Installation

source /etc/lsb-release

PUPPET_RELEASE="puppetlabs"
BASE_URL="https://apt.puppetlabs.com"

REPO_URL="$BASE_URL/$PUPPET_RELEASE-release-pc1-$DISTRIB_CODENAME.deb"
PUPPET_APT_LIST="/etc/apt/sources.list.d/puppetlabs-pc1.list"

case "$(hostname -s)" in
  puppet-master) PUPPET_INST_TYPE=(puppet-agent puppetserver) ;;
  puppet-agent) PUPPET_INST_TYPE=(puppet-agent) ;;
  *) echo "Unexpected hostname: $(hostname -s). Exiting" && exit 1 ;;
esac

function add_puppet_repo() {
  echo "Add puppet repo"
  wget "$REPO_URL"
  dpkg -i "$PUPPET_RELEASE"-release-pc1-"$DISTRIB_CODENAME".deb
  apt-get update -yq && apt-get upgrade -yq
  apt-get autoremove -yq
}

function install_puppet() {
  echo "Installing packages"
  for pack in ${PUPPET_INST_TYPE[@]}
  do
    apt-get -y install "$pack" > /dev/null 2>&1
  done
}

# Execute
if [ ! -f "$PUPPET_APT_LIST" ]
then
  add_puppet_repo
fi

for pack in ${PUPPET_INST_TYPE[@]}
do
  dpkg-query -l $(echo "$pack") > /dev/null 2>&1
  ec=$?
  if [ "$ec" != 0 ]
  then
    install_puppet
  fi
done
