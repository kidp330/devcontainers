ARG BASE_IMG
FROM $BASE_IMG

RUN \
  KERL_BUILD_DOCS=yes \
  mise install --yes elixir erlang \
  && mise use -g elixir erlang \
  && mise reshim
# TODO: set locale and fix erlang docs compilation
ENV \
  PROMPT_HEAD='λ>' \
  # purple
  PROMPT_HEAD_COLOR='\[\033[35m\]'

ENTRYPOINT [ "iex" ]