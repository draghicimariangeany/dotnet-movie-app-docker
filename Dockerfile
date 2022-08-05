FROM ubuntu:18.04 as base

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb; apt-get install -y -f
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y universe
RUN apt-get install -y apt-transport-https
RUN apt-get update -y
RUN apt-get install -y dotnet-sdk-2.2

COPY /movie-app/ .

RUN dotnet ef database update
RUN dotnet build
RUN dotnet publish

CMD dotnet run
