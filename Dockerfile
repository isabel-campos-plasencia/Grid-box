ROM centos:centos8

# This install compilers, scripters, and related tools

RUN yum -y groupinstall "Development Tools"

# Additional software for Math and MPI support

RUN yum -y install \
    wget \
    tcsh \
    emacs \
    which \
    gnuplot \
    gsl* \
    gmp* \
    openmpi*\
    openssl*

# Setting some useful environment

RUN echo 'export GCC=gcc' > /etc/profile.d/scicomp.sh 
RUN echo 'export PATH=$PATH:/usr/lib64/openmpi/bin:/usr/lib64/openmpi/lib' >> /etc/profile.d/scicomp.sh
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib' >> /etc/profile.d/scicomp.sh
RUN echo 'export MPI_INCLUDE=/usr/include/openmpi-x86_64' >> /etc/profile.d/scicomp.sh

# Creating regular user developer

RUN /usr/sbin/useradd developer

RUN echo '/******************************************************************************/' > /etc/motd 
RUN echo '/**********   WELCOME TO CENTOS8 GRID-box enabled CONTAINER  ******************/' >> /etc/motd 
RUN echo '/                                                                              /' >> /etc/motd 
RUN echo '/ You might need to source the environment depending on the local directories  /' >> /etc/motd 
RUN echo '/ you mount (-v option) by typing: source /etc/profile.d/scicomp.sh            /' >> /etc/motd 
RUN echo '/                                                                              /' >> /etc/motd
RUN echo '/ It is advisable to switch to user "developer" (su developer) if you have     /' >> /etc/motd 
RUN echo '/ not done already so when starting the container (option --user developer)    /' >> /etc/motd 
RUN echo '/                                                                              /' >> /etc/motd 
RUN echo '/ If you detect problems please send an e-mail to: isabel.campos@csic.es       /' >> /etc/motd
RUN echo '/                                                                              /' >> /etc/motd
RUN echo '/******************************************************************************/' >> /etc/motd 

RUN echo '/usr/bin/cat /etc/motd' >> /etc/profile.d/scicomp.sh

RUN mkdir -p /opt
RUN mkdir -p /opt/projects
RUN mkdir -p /opt/projects/Grid
WORKDIR /opt/projects/Grid

RUN chown -R developer.users /opt

WORKDIR /opt/projects/Grid

CMD ["/bin/bash"]

