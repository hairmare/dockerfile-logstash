# hairmare/logstash

Build a [hairmare/gentoo-laymanadd](https://registry.hub.docker.com/u/hairmare/gentoo-laymanadd/) based [docker](https://docker.io) logstash image.

Installs a binary version of [logstash](http://logstash.net/) from the unofficial [travisghansen/chaos overlay](https://github.com/travisghansen/chaos) from github.

Sets up logstash to read all existing docker container log files into elasticsearch_http.

Contains a ``logstash.service`` file for use with [CoreOS](https://coreos.com)

May be started without CoreOS like so.

````
docker run -t --name=logstash --link=elasticsearch:es -v /var/lib/docker:/var/lib/docker hairmare/logstash bash -c '/sbin/rc default && exec tail-syslog'
````

Please note that this is not production ready and done more out of curiosity.

