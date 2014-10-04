#!/bin/bash
#FAJLINUX Modelo de script INIT
 
start() {
  echo $'Executando start!' > /var/log/meu-servico.log
  service httpd start
}
  
stop() {
  echo 'Executando stop!' > /var/log/meu-servico.log
  service httpd stop
}
  
restart() {
  service httpd restart
}                                                                                                                                                                         
                                                                                                                                                                            
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart}"
    exit 1
esac
  
exit $?

