#!/bin/bash
# This file contains custom bash functions for various tasks
# Usage: source .bash_functions in your .bashrc or .bash_profile

# This converts all those deprecated keys to the new format
# Example: apt-key-migrate 91E7EE5E team-xbmc
# use sudo apt-key list to get the key (Last 8 characters without space)
function apt-key-migrate {
    typeset key="$1"
    typeset dest="$2"

    if [ -z "$key" ] || [ -z "$dest" ];
    then
        echo "Usage: apt-key-migrate <key> <destination>"
        return 1
    fi

    sudo apt-key --keyring /etc/apt/trusted.gpg export $key | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/$dest.gpg
    sudo apt-key --keyring /etc/apt/trusted.gpg del $key
}

# This will open file/directory or URL by user-prefferred program
function open {
    if [ $# -eq 0 ]
      then
        xdg-open .
    else
        xdg-open $1
    fi
}

function package_update {
    case "$1" in
        "repo")
            echo "Updating source repositories"
            echo "############################"
            echo "- Updating apt sources"
            sudo apt-get update
            echo "- Updating flatpack sources"
            flatpak update
            ;;
        "list")
            echo "Listing upgradables"
            echo "############################"
            echo "- Updating apt sources"
            sudo apt-get update
            echo "- Listing apt upgradables"
            sudo apt list --upgradeable
            echo "- Listing flatpak upgradables"
            flatpak update
            ;;
        "update")
            echo "Updating upgradables"
            echo "############################"
            echo "- Updating apt sources"
            sudo apt-get update
            echo "- Listing apt upgradables"
            sudo apt list --upgradeable
            echo "- Upgrading apt packages"
            sudo apt-get upgrade -y
            echo "- Upgrading kernel packages"
            sudo apt-get dist-upgrade -y
            echo "- Upgrading flatpak packages"
            flatpak update -y
            echo "- Auto-removing apt packages"
            sudo apt-get autoremove -y
            echo "- Auto-cleaning apt packages"
            sudo apt-get autoclean -y
            echo "- Listing apt upgradables"
            sudo apt list --upgradeable
            echo "- Listing flatpak upgradables"
            flatpak update
            ;;
        "clean")
            echo "- Auto-removing apt packages"
            sudo apt-get autoremove -y
            echo "- Auto-cleaning apt packages"
            sudo apt-get autoclean -y
            ;;
        *)
            echo "Updating upgradables"
            echo "############################"
            echo "- Updating apt sources"
            sudo apt-get update
            echo "- Listing apt upgradables"
            sudo apt list --upgradeable
            echo "- Upgrading apt packages"
            sudo apt-get upgrade -y
            echo "- Upgrading kernel packages"
            sudo apt-get dist-upgrade -y
            echo "- Upgrading flatpak packages"
            flatpak update -y
            echo "- Auto-removing apt packages"
            sudo apt-get autoremove -y
            echo "- Auto-cleaning apt packages"
            sudo apt-get autoclean -y
            echo "- Listing apt upgradables"
            sudo apt list --upgradeable
            echo "- Listing flatpak upgradables"
            flatpak update
            ;;
    esac
}
