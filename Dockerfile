#- Base image 
FROM ubuntu:14.04
MAINTAINER Ronak Kogta <tau.ronak@gmail.com>

#- Configure Image 
RUN export uid=1000 gid=1000 && \ 
mkdir -p /home/developer && \
echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
echo "developer:x:${uid}:" >> /etc/group && \
echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
chmod 0440 /etc/sudoers.d/developer && \
chown ${uid}:${gid} -R /home/developer
ENV HOME /home/developer

#- Install Softwares
RUN echo "Acquire::http::proxy \"http://proxy.iiit.ac.in:8080/\";" >> /etc/apt/apt.conf
RUN echo "Acquire::https::proxy \"https://proxy.iiit.ac.in:8080/\";" >> /etc/apt/apt.conf
RUN apt-get update && apt-get install -y firefox

#- Run stuff
USER developer 
CMD /usr/bin/firefox
