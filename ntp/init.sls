# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "ntp/map.jinja" import ntp with context %}

ntp:
  pkg.installed:
    - name: {{ ntp.package }}

  file.managed:
    - name: {{ ntp.config }}
    - template: jinja
    - source: salt://ntp/templates/ntp.conf.jinja
    - user: root
    - group: root
    - mode: 0444
    - require:
      - pkg: {{ ntp.package }}
  
  # Daemon launch options
  # Key config

  service.running:
    - name: {{ ntp.service }}
    - enable: true
    - require:
      - pkg: {{ ntp.package }}
    - watch:
      - file: {{ ntp.config }}
