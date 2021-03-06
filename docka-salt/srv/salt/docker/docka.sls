include:
  - docker

#nginx_container_present:
#  dockerng.image_present:
#    - name: jwilder/nginx-proxy
#    - insecure_registry: True

nginx_container_present:
  cmd.run:
    - name: /usr/bin/docker pull jwilder/nginx-proxy

install_nginx_proxy_container:
  dockerng.running:
    - name: nginx-proxy
    - image: jwilder/nginx-proxy
    - port_bindings:
      - 80:80
    - detach: True
    - binds: /var/run/docker.sock:/tmp/docker.sock:ro

docka_container_present:
  cmd.run:
{% if 'prod' in grains['env'] %}
    - name: /usr/bin/docker pull forresta/docka-docka-docka
{% elif 'test' in grains['env'] %}
    - name: /usr/bin/docker pull forresta/docka-docka-docka-test
{% endif %}

#docka_container_present:
#   dockerng.image_present:
#{% if 'prod' in grains['env'] %}
#    - name: forresta/docka-docka-docka
#{% elif 'test' in grains['env'] %}
#    - name: forresta/docka-docka-docka-test
#{% endif %}
#    - insecure_registry: True

install_docka_project_container:
  dockerng.running:
{% if 'prod' in grains['env'] %}
    - name: docka-docka-docka
    - image: forresta/docka-docka-docka
{% elif 'test' in grains['env'] %}
    - name: docka-docka-docka-test
    - image: forresta/docka-docka-docka-test
{% endif %}
    - port_bindings:
      - 5000:5000
    - environment:
      - VIRTUAL_HOST: test.hungryadmin.com
    - detach: True
