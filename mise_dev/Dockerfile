FROM jdxcode/mise:latest

ARG HISTPERSIST

ENV \
  PROMPT_HEAD='$ ' \
  HISTPERSIST=${HISTPERSIST}

RUN \
  apt-get update && apt-get install \
  trash-cli \
  bash-completion \
  tldr \
  && /bin/rm -rf /var/lib/apt/lists/* \
  && echo 'source <(mise activate bash)' >> ~/.bashrc

ENTRYPOINT [ "/bin/bash", "-o", "pipefail" ]
