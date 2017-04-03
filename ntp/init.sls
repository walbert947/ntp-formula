{% from "ntp/map.jinja" import ntp_settings with context %}

ntp:
  pkg.installed:
    - name: {{ ntp_settings.package|yaml }}
  
  file.managed:
    - name: {{ ntp_settings.conf_file|yaml }}
    - template: jinja
    - source: salt://ntp/templates/ntp.conf.jinja
    - user: root
    - group: root
    - mode: '0444'
    - require:
      - pkg: ntp_package
  
  service.running:
    - name: {{ ntp_settings.service|yaml }}
    - enable: true
    - require:
      - pkg: ntp
    - watch:
      - file: ntp
      - file: ntp_defaults
      - file: ntp_keys

ntp_defaults:
  file.managed:
    - name: {{ ntp_settings.defaults|yaml }}
    - template: jinja
    - source: salt://ntp/templates/defaults.jinja
    - user: root
    - group: root
    - mode: '0444'
    - require:
      - pkg: ntp_package
  
ntp_keys:
  file.managed:
    - name: {{ ntp_settings.keys_file|yaml }}
    - template: jinja
    - source: salt://ntp/templates/keys.jinja
    - user: root
    - group: root
    - mode: '0400'
    - require:
      - pkg: ntp_package
