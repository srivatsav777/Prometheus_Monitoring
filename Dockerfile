FROM centos:7

WORKDIR /home/centos
RUN  yum -y update \
  && yum install -y epel-release \
  && yum install -y sudo \  
  && yum install -y wget \
  && yum install -y cronie \
  && yum install -y python-pip \  
  && rm -rf /var/lib/apt/lists/*
RUN /usr/bin/wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
RUN /bin/tar -xf node_exporter-0.18.1.linux-amd64.tar.gz
RUN /bin/mv node_exporter-0.18.1.linux-amd64 node_exporter
RUN /bin/mkdir -p /var/lib/prometheus-dropzone
RUN /usr/bin/pip install requests
COPY checks.py checks.py
RUN /bin/echo  "* * * * * root sudo /usr/bin/python /home/centos/checks.py 2>&1 > /home/centos/metrics.log"  >> /etc/crontab
COPY node_exporter.service /etc/systemd/system/node_exporter.service
RUN systemctl enable node_exporter
CMD ["systemctl", "start", "node_exporter"]
EXPOSE 9100