FROM ubuntu:16.04
MAINTAINER sminot@fredhutch.org

# Install prerequisites
RUN apt update && \
	apt-get install -y build-essential wget unzip

# Use /share as the working directory
RUN mkdir /share
WORKDIR /share

# Download MOCAT2 unpack, and install it
# Note that this distribution does not include the functional annotation database
RUN cd /usr/ && \
	wget http://vm-lux.embl.de/~kultima/share/MOCAT/v2.0/MOCAT2-lite.zip && \
	unzip MOCAT2-lite.zip && \
	rm MOCAT2-lite.zip && \
	cd /usr/MOCAT && \
	echo yes | perl setup.MOCAT.pl

# Add to the PATH
ENV PATH="${PATH}:/usr/MOCAT/src"
