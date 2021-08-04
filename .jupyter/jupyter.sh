
workPath=$(cd $(dirname $0)/; pwd)
pidFile=$workPath/jupyter.pid
logFile=$workPath/jupyter.log

function check_pid(){
	if [ -f $pidFile ];then
		pid=$(cat $pidFile)
		if [ -n $pid ];then
			tasks=$(ps -p $pid | grep -v "PID TTY" | wc -l)
			return $tasks
		fi
	fi
	return 0
}


function start(){
	check_pid
	tasks=$?
	if [ $tasks -gt 0];then
		echo -n "The Jupyter Service is already running with PID:"
		$(cat $pidFile)
		return 1
	fi
	nohup/usr/local/bin/jupyter lab >> $logFile 2>&1 &
	echo $! > $pidFile
	echo "The Jupyter Service start to run, Pid=$!"
}


function stop(){
	check_pid
	tasks=$?
	pid=$(cat $pidFile)
	if [ $tasks -gt 0];then
		kill -9 $pid
		echo "Jupyter Service stopped...."
	else
		echo "Jupyter Service is not running"
	fi
}


function restart(){
	stop
	sleep 2
	start
}

function status(){
	check_pid
	tasks=$?
	if [ $tasks -gt 0];then
		echo -n "Jupyter Service is already running with PID:"
		cat $pidFile
		echo "please check the log for details:"$logFile
	else
		echo "Jupyter Service has stopped"
	fi
}

function help(){
	echo "$0 start|stop|restart|status"
}

case $1 in 
	start) start;;
	stop) stop;;
	restart) restart;;
	status) status;;
	*) help;;
esac
