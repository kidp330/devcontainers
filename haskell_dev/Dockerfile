ARG BASE_IMG
FROM $BASE_IMG

# RUN \
#      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh \
#   && mise link && \
#   mise use -g haskell && \ 
#   stack install ghcid hlint && \
#   apt-get update && apt-get install -y source-highlight && rm -rf /var/lib/apt/lists/* 
# # there might be a better solution than source-highlight
# # Try hlint works

ENV \
  PROMPT_HEAD='λ>' \
  # purple
  PROMPT_HEAD_COLOR='\[\033[35m\]'

ENTRYPOINT [ "ghci" ]