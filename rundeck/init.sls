rundeck-repo:
  pkg.installed:
    - sources:
      - rundeck-repo: http://repo.rundeck.org/latest.rpm

rundeck:
  pkg.installed

rundeckd:
  service.running:
    - enable: True

rundeck-users:
  file.managed:
    - name: /etc/rundeck/realm.properties
    - source: salt://rundeck/files/realm.properties
    - template: jinja
