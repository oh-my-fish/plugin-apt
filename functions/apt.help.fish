function apt.help
  echo -e "Lightweight APT utility for quickly managing packages.

Usage: apt COMMAND [OPTIONS] [arg...]

Options:
  -d, --dry-run   Simulate the result of a command without taking action.
  -h, --help      Display this help message and exit.
  -y, --force-yes Do not prompt and assume yes for all queries.

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
  search-file Searches for packages that contain the given files.
  show        Shows information about packages.
  update      [Alias: up] Updates the list of downloadable packages.
  upgrade     Upgrades packages.

$__apt_cow_message"
end
