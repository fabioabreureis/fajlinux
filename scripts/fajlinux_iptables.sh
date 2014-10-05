iptables -F
iptables -X


#alteracoes basicas
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
echo 0 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter

# Abre para a interface de loopback:
iptables -A INPUT -p tcp -i lo -j ACCEPT


# Abre as portas referentes aos servicos usados:
# SSH:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Apache
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT


#mysql
iptables -A INPUT -p tcp --dport 3306 -j DROP


#ftp
iptables -A INPUT -p tcp --dport 21 -j ACCEPT

#portas passivas ftp
iptables -A INPUT -p tcp -m tcp --dport 49152:65534 --syn -j ACCEPT

# Garante que o firewall permitira pacotes de conexoes iniciadas:
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


#protecao contra DDoS
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT

#contra pacotes invalidos
iptables -A INPUT -m state --state INVALID -j DROP


# Bloqueia conexoes demais portas:
iptables -A INPUT -p tcp --syn -j DROP


# Bloqueia as portas UDP de 0 a 1023 (exceto as abertas acima):
iptables -A INPUT -p udp --dport 0:1023 -j DROP

# Bloqueia forward
iptables -P FORWARD DROP


