FROM conda/miniconda3

COPY requirements.txt .
RUN \
    apt-get update && apt-get install -y git \
        && /bin/rm -rf /var/lib/apt/lists/* \ 
    && pip install -r requirements.txt

ENTRYPOINT ["python3", "--version"]
