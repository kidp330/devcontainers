ARG BASE_DEBIAN
FROM $BASE_DEBIAN


RUN \
  apt-get update && apt-get -y install build-essential autoconf m4 libncurses5-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev default-jdk libwxgtk-webview3.2-1 libwxgtk-webview3.2-dev \
    && /bin/rm -rf /var/lib/apt/lists/* \
  && mise install --yes elixir erlang \
  && mise use -g elixir erlang \
  && mise reshim
# TODO: set locale and fix erlang docs compilation
ENV \
  PROMPT_HEAD='λ>' \
  # purple
  PROMPT_HEAD_COLOR='\[\033[35m\]'

ENTRYPOINT [ "iex" ]