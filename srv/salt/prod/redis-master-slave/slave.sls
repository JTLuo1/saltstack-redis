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

{{ pillar['redis_install_dir'] }}/bin/redis-cli replicaof {{ pillar['redis_master_ip'] }} {{ pillar['redis_port'] }}:
  cmd.run
