FROM opensuse/tumbleweed

# install base packages
RUN zypper ref && zypper -n install apache2 git
RUN zypper -n install daps ruby2.6-rubygem-asciidoctor
RUN zypper -n install python3-Sphinx python3-restructuredtext_lint
RUN zypper -n install pandoc

COPY global.conf /etc/apache2/
COPY global.conf /etc/apache2/sysconfig.d/
CMD /usr/sbin/apache2ctl -D FOREGROUND

VOLUME  ["/srv/www/htdocs"]
VOLUME  ["/root"]


EXPOSE 80
