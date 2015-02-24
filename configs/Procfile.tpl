sickrage: python /sickrage/SickBeard.py --datadir={{ default .Env.SB_DATA "/data" }} --config={{ default .Env.SB_DATA "/data" }}/config.ini
dnsmasq: dnsmasq -kd