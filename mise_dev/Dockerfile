FROM jdxcode/mise:latest

ARG HOST_CONFIG
ARG HISTPERSIST

COPY \
  ./${HOST_CONFIG}/.bash* \ 
  /root/

ENV \
  PROMPT_HEAD='$ ' \
  HISTPERSIST=${HISTPERSIST}

RUN \
  apt-get update && apt-get install trash-cli && /bin/rm -rf /var/lib/apt/lists/* \
  && echo 'source <(mise activate bash)' >> ~/.bashrc \
  && echo 'source <(mise activate bash)' >> ~/.bashrc
ENTRYPOINT [ "/bin/bash", "-o", "pipefail" ]