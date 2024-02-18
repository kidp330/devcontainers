ARG BASE_IMG
FROM $BASE_IMG

RUN \
  mise install --yes elixir erlang \
  && mise use -g elixir erlang \
  && mise reshim

ENV \
  PROMPT_HEAD='λ>' \
  # purple
  PROMPT_HEAD_COLOR='\[\033[35m\]'

ENTRYPOINT [ "iex" ]