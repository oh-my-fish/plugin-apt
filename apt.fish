# SYNOPSIS
#   apt COMMAND [OPTIONS] [arg...]
#
# USAGE
#   See `apt --help` for details.
#

function apt -d "Short and friendly command wrapper for APT"
    # Check for super cow powers.
    if type -f -q cowsay
        set -g __APT_COW 1
        set -g __APT_COW_MESSAGE "This APT has Super Cow Powers."
    else
        set -g __APT_COW_MESSAGE "This APT does not have Super Cow Powers."
    end

    # If --help, -h, or no command given, display usage message.
    if begin; not set -q argv[1]; or contains -- -h $argv; or contains -- --help $argv; end
        __apt_help
        return 0
    end

    switch $argv[1]
        case autoremove
            sudo apt-get autoremove

        case check
            sudo apt-get check

        case clean
            sudo apt-get autoclean

        case install in
            sudo apt-get install $argv[2..-1]

        case policy
            env LANG=C apt-cache policy

        case ppa
            if not set -q argv[2]
                echo "No PPA specified."
                return 1
            end

            switch $argv[2]
            case list
                for APT in (find /etc/apt/ -name \*.list)
                    grep -o "^deb http://ppa.launchpad.net/[a-z0-9\-]\+/[a-z0-9\-]\+" $APT | while read ENTRY
                        set USER (echo $ENTRY | cut -d/ -f4)
                        set PPA (echo $ENTRY | cut -d/ -f5)
                        echo $USER/$PPA
                    end
                end

            case remove
                sudo add-apt-repository --remove ppa:$argv[3]

            case purge
                sudo ppa-purge ppa:$argv[3]

            case '*'
                sudo add-apt-repository ppa:$argv[2]
            end

        case purge
            sudo apt-get --purge remove $argv[2..-1]

        case reconfigure
            sudo dpkg-reconfigure $argv[2..-1]

        case remove rm
            sudo apt-get remove $argv[2..-1]

        case search
            apt-cache search $argv[2..-1]

        case show
            apt-cache show $argv[2..-1]

        case update up
            sudo apt-get update

        case upgrade
            if set -q argv[2]; and test $argv[2] = dist
                sudo apt-get dist-upgrade
            else
                sudo apt-get upgrade
            end

        case moo
            if set -q __APT_COW
                cowsay "Have you mooed today?"
            else
                echo $__APT_COW_MESSAGE
            end

        case '*'
            apt-cache show $argv
    end
end


function __apt_help
    echo -e "Lightweight APT utility for quickly managing packages.

Usage: apt COMMAND [OPTIONS] [arg...]

Options:
    -h, --help  Display this help message and exit.

Commands:
    autoremove  Remove automatically all unused packages.
    check       Verify that there are no broken dependencies.
    clean       Erase old downloaded archive files.
    install     [Alias: in] Install packages.
    policy      Shows policy settings.
    ppa         Adds or removes PPA packages sources.
    purge       Removes packages and their configuration files.
    reconfigure Reconfigures packages.
    remove      [Alias: rm] Removes packages.
    search      Searches for packages.
    show        Shows information about packages.
    update      [Alias: up] Updates the list of downloadable packages.
    upgrade     Upgrades packages.

$__APT_COW_MESSAGE"
end
