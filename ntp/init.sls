{% from "ntp/map.jinja" import ntp with context %}

ntp_package:
  pkg.installed:
    - name: {{ ntp.package }}

ntp_config:
  file.managed:
    - name: {{ ntp.conf_file }}
    - template: jinja
    - source: salt://ntp/templates/ntp.conf.jinja
    - user: root
    - group: root
    - mode: '0444'
    - require:
      - pkg: ntp_package

ntp_defaults:
  file.managed:
    - name: {{ ntp.defaults }}
    - template: jinja
    - source: salt://ntp/templates/defaults.jinja
    - user: root
    - group: root
    - mode: '0444'
    - require:
      - pkg: ntp_package
  
ntp_keys:
  file.managed:
    - name: {{ ntp.keys_file }}
    - template: jinja
    - source: salt://ntp/templates/keys.jinja
    - user: root
    - group: root
    - mode: '0400'
    - require:
      - pkg: ntp_package

ntp_service
  service.running:
    - name: {{ ntp.service }}
    - enable: true
    - require:
      - pkg: ntp_package
    - watch:
      - file: ntp_config
      - file: ntp_defaults
      - file: ntp_keys
