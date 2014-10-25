FROM hairmare/gentoo-laymanadd
MAINTAINER Lucas Bickel <hairmare@purplehaze.ch>

RUN layman-add travisghansen-chaos git git://github.com/travisghansen/chaos.git
RUN ebuild /var/lib/layman/travisghansen-chaos/sys-apps/logstash/logstash-1.4.2.ebuild digest

# configure java for logstash
RUN echo 'USE="${USE} -X -cups"' >> /etc/portage/make.conf

# logstash deps
RUN echo 'dev-python/urllib3 ~amd64' >> /etc/portage/package.accept_keywords/logstash
RUN echo 'dev-python/pyes ~amd64' >> /etc/portage/package.accept_keywords/logstash

# silly stuff done to get the progress overlay that contains virtual/python-argparse for logstash
RUN PYTHON_TARGETS="python2_7" emerge -v subversion
RUN echo 'app-portage/layman subversion' >> /etc/portage/package.use/layman-progress-overlay
RUN emerge app-portage/layman --newuse -v && layman -a progress

RUN emerge -v logstash
RUN rc-update add logstash default

# configure logstash instance
ADD agent.conf /etc/logstash/conf.d/
# rewrite config on boot
ADD logstash.start /etc/local.d/
RUN chmod +x /etc/local.d/logstash.start

RUN eselect news read new

CMD bash -c '/sbin/rc default && exec tail-syslog'
