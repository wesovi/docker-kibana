FROM nginx:1.7
MAINTAINER Iván Corrales Solera <developer@wesovi.com>

ENV KIBANA_PKG  kibana-4.0.0-linux-x64
ENV KIBANA_HOME /opt/kibana

#Download kibana

ADD https://download.elasticsearch.org/kibana/kibana/$KIBANA_PKG.tar.gz /tmp/kibana.tar.gz
ADD bin/run.sh /usr/local/bin/run


RUN mkdir -p $KIBANA_HOME
RUN tar -xvzf /tmp/kibana.tar.gz && mv $KIBANA_PKG/* /opt/kibana 

COPY config/kibana.yml /opt/kibana/config/kibana.yml
COPY bin/run.sh /usr/local/bin/run
COPY patch/index.js /opt/kibana/src/public/index.js
RUN chmod +x /usr/local/bin/run
COPY bin/kibana /opt/kibana/bin/kibana
RUN chmod +x /opt/kibana/bin/kibana
EXPOSE 5601

WORKDIR $KIBANA_HOME

CMD /opt/kibana/bin/kibana