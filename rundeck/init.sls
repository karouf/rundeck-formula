{% from "rundeck/map.jinja" import rundeck with context %}

rundeck-repo:
  pkgrepo.managed:
    - humanname: Rundeck repository
    - gpgcheck: 1
    {%- if grains['os_family'] == 'RedHat' %}
    - name: rundeck
    - baseurl: {{ rundeck.mirror_url }}
    - gpgkey: {{ rundeck.gpgkey }}
    {%- elif grains['os_family'] == 'Debian' %}
    - name: {{ rundeck.mirror_url }}
    - key_url: {{ rundeck.gpgkey }}
    {%- endif %}
    - require_in:
      - pkg: rundeck

rundeck:
  pkg.installed:
    - refresh: True

rundeckd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/rundeck/realm.properties

rundeck-users:
  file.managed:
    - name: /etc/rundeck/realm.properties
    - source: salt://rundeck/files/realm.properties
    - template: jinja
    - mode: 0640

/etc/rundeck/rundeck-config.properties:
  file.managed:
    - source: salt://rundeck/files/rundeck-config.properties
    - template: jinja
    - mode: 0640

/etc/rundeck/project.properties:
  file.managed:
    - source: salt://rundeck/files/project.properties
    - template: jinja
    - mode: 0640