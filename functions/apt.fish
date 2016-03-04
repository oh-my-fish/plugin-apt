# SYNOPSIS
#   apt COMMAND [OPTIONS] [arg...]
#
# USAGE
#   See `apt --help` for details.
function apt -d "Short and friendly command wrapper for APT"
  # Check for super cow powers.
  if type -f -q cowsay
    set -g __apt_cow 1
    set -g __apt_cow_message "This APT has Super Cow Powers."
  else
    set -g __apt_cow_message "This APT does not have Super Cow Powers."
  end

  # If --help, -h, or no command given, display usage message.
  if begin; not set -q argv[1]; or contains -- -h $argv; or contains -- --help $argv; end
    apt.help
    return 0
  end

  # Parse command options.
  set i (contains -i -- -d $argv; or contains -i -- --dry-run $argv)
  if test -n "$i"
    set -e argv[$i]

    set dry_run 1
    set apt_get_flags $apt_get_flags "-s"
  end
  set -e i

  set i (contains -i -- -y $argv; or contains -i -- --force-yes $argv)
  if test -n "$i"
    set -e argv[$i]

    set force_yes 1
    set apt_get_flags $apt_get_flags "-y"
    set ppa_purge_flags $ppa_purge_flags "-y"
  end

  # Parse and execute the given command.
  switch $argv[1]
    case autoremove
      sudo apt-get $apt_get_flags autoremove

    case check
      sudo apt-get $apt_get_flags check

    case clean
      sudo apt-get $apt_get_flags autoclean

    case install in
      sudo apt-get $apt_get_flags install $argv[2..-1]

    case policy
      env LANG=C apt-cache policy

    case ppa
      if not set -q argv[2]
        echo "No PPA specified."
        return 1
      end

      if set -q dry_run
        echo "Dry runs are not supported for PPA commands."
        return 1
      end

      switch $argv[2]
        case list
          for apt in (find /etc/apt/ -name \*.list)
            grep -o "^deb http://ppa.launchpad.net/[a-z0-9\-]\+/[a-z0-9\-]\+" $apt | while read entry
              set user (echo $entry | cut -d/ -f4)
              set ppa (echo $entry | cut -d/ -f5)
              echo $user/$ppa
            end
          end

        case purge
          sudo ppa-purge $ppa_purge_flags ppa:$argv[3]

        case remove
          sudo add-apt-repository --remove ppa:$argv[3]

        case '*'
          sudo add-apt-repository ppa:$argv[2]
      end

    case purge
      sudo apt-get $apt_get_flags --purge remove $argv[2..-1]

    case search-file
      type -q apt-file
        and apt-file search $argv[2..-1]
        or echo "Please install apt-file first."

    case reconfigure
      sudo dpkg-reconfigure $argv[2..-1]

    case remove rm
      sudo apt-get $apt_get_flags remove $argv[2..-1]

    case search
      apt-cache search $argv[2..-1]

    case show
      apt-cache show $argv[2..-1]

    case update up
      sudo apt-get $apt_get_flags update

    case upgrade
      if set -q argv[2]; and test $argv[2] = dist
        sudo apt-get $apt_get_flags dist-upgrade
      else
        sudo apt-get $apt_get_flags upgrade
      end

    case moo
      if set -q __apt_cow
        cowsay "Have you mooed today?"
      else
        echo $__apt_cow_message
      end

    case '*'
      apt-cache show $argv
  end
end
