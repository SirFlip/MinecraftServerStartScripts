#!/bin/bash

is_running() {
	if [ ! -e java.pid ]; then
		return 1
	fi
	
	pid=$(cat java.pid)
	if [ -z $pid ]; then
		return 1
	fi
	
	ps -eo "%p" | grep "^\\s*$pid\\s*\$" > /dev/null
	return $?
}


if [ ! -e service.name ]; then 
  exit -1
fi

SERVICE_NAME=$(cat service.name)

while [ -e server.run ]; do 
    echo "WatchDog-Check"
	if is_running; then
		echo "Server running"
		sleep 10
	else
		echo "Server starting"
		$SERVICE_NAME start
	fi
done
echo "WatchDog-Quit"´