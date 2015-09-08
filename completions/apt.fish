complete -c apt -n "not __fish_use_subcommand" -s d -l dry-run
complete -c apt -n "not __fish_use_subcommand" -s h -l help
complete -c apt -n "not __fish_use_subcommand" -s y -l force-yes

complete -c apt -n "__fish_use_subcommand" -a autoremove -f

complete -c apt -n "__fish_use_subcommand" -a check -f

complete -c apt -n "__fish_use_subcommand" -a clean -f

complete -c apt -n "__fish_use_subcommand" -a "install in" -x

complete -c apt -n "__fish_use_subcommand" -a policy -f

complete -c apt -n "__fish_use_subcommand" -a ppa -x
complete -c apt -n "__fish_seen_subcommand_from ppa" -a "list purge remove" -f

complete -c apt -n "__fish_use_subcommand" -a purge -x

complete -c apt -n "__fish_use_subcommand" -a reconfigure -x
complete -c apt -n "__fish_seen_subcommand_from reconfigure" -a "(__fish_print_packages)" -f

complete -c apt -n "__fish_use_subcommand" -a "remove rm" -x
complete -c apt -n "__fish_seen_subcommand_from remove" -a "(__fish_print_packages)" -f
complete -c apt -n "__fish_seen_subcommand_from rm" -a "(__fish_print_packages)" -f

complete -c apt -n "__fish_use_subcommand" -a search -x

complete -c apt -n "__fish_use_subcommand" -a show -x
complete -c apt -n "__fish_seen_subcommand_from show" -a "(__fish_print_packages)" -f

complete -c apt -n "__fish_use_subcommand" -a "update up" -f

complete -c apt -n "__fish_use_subcommand" -a upgrade -f
complete -c apt -n "__fish_seen_subcommand_from upgrade" -a "(__fish_print_packages)" -f
