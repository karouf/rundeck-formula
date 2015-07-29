{% set jobs_dir = salt.pillar.get('rundeck:jobs:directory', '/var/rundeck/jobs') %}
{% set jobs_format = salt.pillar.get('rundeck:jobs:format', 'xml') %}

rundeck-available:
  cmd.run:
    - name: while [ `http_proxy= curl http://localhost:4440 > /dev/null 2>&1;echo $?` != 0 ]; do sleep 1; done > /dev/null
    - timeout: 60
    - require:
      - service: rundeckd

{% for project, jobs in salt.pillar.get('rundeck:jobs:map', {}).items() %}
{% for job in jobs %}
rd-jobs load -d update -r -p {{ project }} -F {{ jobs_format }} -f {{ jobs_dir }}/{{ job }}.{{ jobs_format }}:
  cmd.run
{% endfor %}
{% endfor %}
