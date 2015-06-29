rundeck-repo:
  pkg.installed:
    - sources:
      - rundeck-repo: http://repo.rundeck.org/latest.rpm

rundeck:
  pkg.installed

rundeckd:
  service.running:
    - enable: True
