# Test Task

keepalived (floating ip version)
 - virtual floating IP managed by keepalived, docker capability NET_ADMIN was added in docker-compose to allow this.
 - Nginx is turned of on non MASTER states via "states.sh" script.
 - Custom network ranges are provided in docker-compose file. 172.198.222.0/24. Also fixed IPs for the containers.
 - Custom entrypoint script to force remove keepalived states.

- Main service (floating IP) URL: http://172.198.222.30/ (automatic failover between master-bkp roles)
- Master URL: http://localhost:8880/
- Backup URL: http://localhost:8881/

 # DRP - Instructions.

 - 0. $ docker compose up -d

 - 1a. http://172.198.222.30/ (shows master message)
 - 1b. http://localhost:8880/ (shows master message)
 - 1c. http://localhost:8881/ (unavailable - nginx process never was up)

 - 2. $ docker kill keepalived_master
 
 - 3a. http://172.198.222.30/ (shows bkp message - may need browser reload)
 - 3b. http://localhost:8880/ (unavailable - nginx container was killed - may need browser reload)
 - 3c. http://localhost:8881/ (shows bkp message - may need browser reload)

 - 4. $ watch -n 5 "docker-compose up -d" to fill out the docker compose app.

 - 3a. http://172.198.222.30/ (shows master message)
 - 3b. http://localhost:8880/ (shows master message)
 - 3c. http://localhost:8881/ (unavailable - nginx was gracefully shutted down by state change script)
