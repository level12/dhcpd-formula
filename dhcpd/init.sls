{% from "dhcpd/map.jinja" import dhcpd with context %}

dhcpd:
  pkg.installed:
    - name: {{ dhcpd.server }}
{% if dhcpd.enable_only %}
  service.enabled:
    - name: {{ dhcpd.service }}
{% elif dhcpd.enable is defined and not dhcpd.enable %}
  service.dead:
    - name: {{ dhcpd.service }}
    - enable: False
{% else %}
  service.running:
    - name: {{ dhcpd.service }}
    - enable: True
    - require:
      - pkg: {{ dhcpd.server }}
    - require:
      - file: {{ dhcpd.config }}
{% endif %}
