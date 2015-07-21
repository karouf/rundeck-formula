{% import_yaml "rundeck/projects/defaults.yaml" as defaults %}

{% set projects_defaults = salt.pillar.get('rundeck:config:projects:defaults', default=defaults, merge=True) %}

{% for name, project in salt.pillar.get('rundeck:projects', {}).items() %}

{% if project == None %}
{% set project = {} %}
{% endif %}

{% set project_defaults = projects_defaults %}
{% do project_defaults.update(project) %}

/var/rundeck/projects/{{ name }}/etc:
  file.directory:
    - user: rundeck
    - group: rundeck
    - makedirs: True

/var/rundeck/projects/{{ name }}/etc/project.properties:
  file.managed:
    - user: rundeck
    - group: rundeck
    - mode: 664
    - source: salt://rundeck/projects/files/project.properties
    - template: jinja
    - defaults:
      project_name: {{ name }}
      project: {{ project_defaults }}

{% for resource in project_defaults.resources %}
{% if resource.source == 'pillar' %}
/var/rundeck/projects/{{ name }}/etc/resources.yaml:
  file.managed:
    - user: rundeck
    - group: rundeck
    - mode: 664
    - source: salt://rundeck/projects/files/resources.yaml
    - template: jinja
    - defaults:
      nodes: {{ resource.nodes }}
{% endif %}
{% endfor %}

{% endfor %}
