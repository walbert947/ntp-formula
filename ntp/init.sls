{% from "ntp/map.jinja" import ntp with context %}

ntp:
  pkg.installed:
    - name: {{ ntp.package }}

#  file.managed:
#    - name: {{ ntp.config }}
#    - template: jinja
#    - source: salt://ntp/files/ntp.conf
#    - context:
#      config: {{ salt['pillar.get']('ntp', {}) }}
#    - require:
#      - pkg: {{ ntp.package }}
  
  # Daemon launch options
  # Key config

  service.running:
    - name: {{ ntp.service }}
    - enable: true
    - require:
      - pkg: {{ ntp.package }}
#    - watch:
#      - file: {{ ntp.config }}
