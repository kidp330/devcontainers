FROM pytorch

ARG WORKSPACE
WORKDIR $WORKSPACE

COPY requirements.txt .
RUN apt update && apt install -y git && pip install -r requirements.txt
