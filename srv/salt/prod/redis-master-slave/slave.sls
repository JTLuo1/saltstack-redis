include:
  - modules.database.redis.install

slave-trasfer-files:
  file.managed:
  - names:
    - {{ pillar['redis_install_dir'] }}/conf/redis.conf:
      - source: salt://redis-master-slave/files/redis.conf.j2
  - template: jinja

redis_server:
  service.running:
    - restart: true

slave-replication:
  cmd.run:
    - name:  {{ pillar['redis_install_dir']  }}/bin/redis-cli -p {{ pillar['redis_port'] }} -a {{ pillar['redis_pass']  }} INFO replication  

