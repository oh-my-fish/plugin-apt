function apt-queue
	set i 0
	tput sc
	set locked (sudo fuser /var/lib/dpkg/lock ^ /dev/null)
	while test -n "$locked"
		set indicator (math $i%4)
		switch $indicator
			case 0
				set j "-"
			case 1
				set j "\\"
			case 2
				set j "|"
			case 3
				set j "/"
		end
		tput rc
		echo -en "\r[$j] Waiting for other software managers to finish..."
		sleep 0.5
		set i (math i+1)
		set locked (sudo fuser /var/lib/dpkg/lock ^ /dev/null)
	end
	#echo -e "\n\nREADY!"
end