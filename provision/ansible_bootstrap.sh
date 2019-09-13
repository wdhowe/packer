#!/bin/bash
# Description: Install ansible - supports apt, yum, and dnf package managers

function set_package_manager
{
    # Determine which package manager to use
    which apt-get &> /dev/null
    apt_retcode=$?
    
    which dnf &> /dev/null
    dnf_retcode=$?

    which yum &> /dev/null
    yum_retcode=$?
    
    if [[ ${apt_retcode} -eq 0 ]] ; then
        package_man="apt-get"
    
    elif [[ ${dnf_retcode} -eq 0 ]] ; then
        package_man="dnf"

    elif [[ ${yum_retcode} -eq 0 ]] ; then
        package_man="yum"
    
    else
        echo ">> Error: Undetermined package manager."
        exit 1
    fi

}

# Set package manager to apt, yum, or dnf
set_package_manager

# Wait a bit to allow the OS to initialize
sleep_time=20
echo -e ">> Sleeping (${sleep_time}) seconds to allow OS time to initialize..."
sleep ${sleep_time}s

# Update repo metadata
echo -e ">> Updating repo cache..."
if [[ ${package_man} == "apt-get" ]]; then
    sudo ${package_man} update
else
    sudo ${package_man} makecache fast
fi

# Install extra package repo for enterprise linux
if [[ ${package_man} == "yum" || ${package_man} == "dnf" ]]; then
    echo -e ">> Adding EPEL repo..."
    sudo ${package_man} install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
fi

echo -e ">> Installing Ansible..."
sudo ${package_man} -y install ansible

# Check to see if installation was successful
which ansible &> /dev/null
ansible_retcode=$?
if [[ ${ansible_retcode} -eq 0 ]]; then
    echo -e ">> Ansible installed successfully."
    exit 0
else
    echo -e "-> Error installing Ansible!"
    exit 1
fi

