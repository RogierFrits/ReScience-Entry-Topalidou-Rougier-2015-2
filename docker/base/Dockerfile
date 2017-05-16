FROM ubuntu:latest
LABEL maintainer "rogier.mars@student.vu.nl"

RUN apt-get update && apt-get install -y python python-dev python-pip python-matplotlib

RUN pip install --upgrade pip && pip install numpy cython
