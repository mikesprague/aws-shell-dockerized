FROM python:3.6

# run some updates and set the timezone to eastern
RUN apt-get clean && apt-get update && apt-get -qy upgrade \
    && apt-get -qy install locales tzdata apt-utils software-properties-common build-essential python3 \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# install aws-cli and aws-shell
RUN pip install --upgrade pip \
    && pip install awscli aws-shell

# clean up after ourselves
RUN apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "aws-shell" ]
