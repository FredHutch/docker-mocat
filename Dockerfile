FROM ubuntu:16.04
MAINTAINER sminot@fredhutch.org

# Install prerequisites
RUN apt update && \
	apt-get install -y build-essential wget unzip && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y mailutils

# Use /share as the working directory
RUN mkdir /share
WORKDIR /share

# Download MOCAT2 unpack, and install it
# Note that the entire database is deleted, to make the image smaller
# It must be saved and hosted separately
RUN cd /usr/ && \
	wget http://vm-lux.embl.de/~kultima/share/MOCAT/v2.0/MOCAT2-lite.zip && \
	unzip MOCAT2-lite.zip && \
	rm MOCAT2-lite.zip && \
	cd /usr/MOCAT && \
	echo yes | perl setup.MOCAT.pl && \
	rm -r dat/* && \
	sed -i "s/EMAIL=''/EMAIL='\$EMAIL'/" /usr/MOCAT/src/runMOCAT.sh
# The last line parameterizes the EMAIL variable in the run script
# That means you must set the env variable EMAIL prior to running runMOCAT.sh

# Add to the PATH
ENV PATH="${PATH}:/usr/MOCAT/src"