FROM centos:centos6
RUN echo proxy=<%= ENV['http_proxy'] %> >> /etc/yum.conf
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN if ! getent passwd kitchen; then useradd -d /home/kitchen -m -s /bin/bash kitchen; fi
RUN echo kitchen:kitchen | chpasswd
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /etc/sudoers.d
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen
RUN chmod 0440 /etc/sudoers.d/kitchen
