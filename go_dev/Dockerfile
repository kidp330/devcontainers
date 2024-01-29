ARG DEBIAN_VERSION
FROM debian:$DEBIAN_VERSION

ARG WORKSPACE
WORKDIR $WORKSPACE

RUN \
	apt-get update \ 
	&& apt-get install -y git curl \ 
	&& rm -rf /var/lib/apt/lists/* \
	\
	&& git clone https://github.com/asdf-vm/asdf.git /usr/local/asdf --single-branch \
	&& echo 'source /usr/local/asdf/asdf.sh' >> ~/.bashrc \
	&& /usr/local/asdf/bin/asdf plugin add golang \
	&& /usr/local/asdf/bin/asdf install golang latest \
	&& /usr/local/asdf/bin/asdf global golang latest
