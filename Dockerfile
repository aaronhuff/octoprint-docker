FROM ubuntu:18.04
MAINTAINER Aaron Huff <aaron.t.huff@gmail.com>
ARG DEBIAN_FRONTEND=noninteractive

# update ubuntu.
RUN apt-get update && apt-get upgrade -y

# install required ubuntu packages.
RUN apt-get install -y python-pip python-dev python-setuptools git libyaml-dev build-essential

# install common python libraries into virtualenv
RUN pip install pip --upgrade

# add user
RUN groupadd -r octoprint && useradd --no-log-init -r -g octoprint octoprint
WORKDIR /home/octoprint
RUN chown -R octoprint /home/octoprint
USER octoprint
RUN pip install https://get.octoprint.org/latest

# Launch OctoPrint
EXPOSE 5000
CMD /home/octoprint/.local/bin/octoprint serve
