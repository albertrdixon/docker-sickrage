[supervisord]
nodaemon  = true
user      = root
loglevel  = {{ default .Env.SUPERVISOR_LOG_LEVEL "INFO" }}

[program:sickrage]
command = python SickBeard.py --datadir={{ default .Env.SB_DATA "/data" }} --config={{ default .Env.SB_DATA "/data" }}/config.ini
directory               = {{ default .Env.SB_HOME "/sickrage" }}
autostart               = true
autorestart             = true
stopsignal              = TERM
stopasgroup             = true
stopwaitsecs            = 10
stdout_logfile          = /dev/stdout
stdout_logfile_maxbytes = 0
stderr_logfile          = /dev/stderr
stderr_logfile_maxbytes = 0