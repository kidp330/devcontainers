# microsoft doesn't like standardised tagging
ARG DEBIAN_VERSION            
FROM mcr.microsoft.com/dotnet/sdk:8.0-${DEBIAN_VERSION}-slim

ARG WORKSPACE

ENV \
  WORKSPACE=$WORKSPACE

WORKDIR $WORKSPACE
