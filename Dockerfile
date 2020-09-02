FROM centos:centos8

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
    openssl* \
    mpfr* 

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

RUN mkdir -p /opt/projects/Grid/LIME
WORKDIR /opt/projects/Grid/LIME
RUN wget https://github.com/usqcd-software/c-lime/archive/master.zip
RUN unzip *.zip

RUN mkdir -p /opt/projects/Grid/LAPACK
WORKDIR /opt/projects/Grid/LAPACK
RUN wget https://github.com/Reference-LAPACK/lapack-release/archive/lapack-3.8.0.zip
RUN unzip *.zip

RUN mkdir -p /opt/projects/Grid/FFTW
WORKDIR /opt/projects/Grid/FFTW
RUN wget https://github.com/FFTW/fftw3/archive/master.zip
RUN unzip *.zip

RUN mkdir -p /opt/projects/Grid/HDF5
WORKDIR /opt/projects/Grid/HDF5
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz
RUN tar xvf *.tar.gz

RUN chown -R developer.users /opt

WORKDIR /opt/projects/Grid
RUN mkdir -p /opt/projects/Grid/SRC
RUN mkdir -p /home/developer/GRID
WORKDIR /opt/projects/Grid/SRC

RUN wget https://github.com/paboyle/Grid/archive/master.zip
RUN unzip master.zip

RUN cd Grid-master
WORKDIR /opt/projects/Grid/SRC/Grid-master
RUN ./bootstrap.sh 
RUN mkdir build
RUN cd build
RUN ./configure --enable-precision=double --enable-simd=AVX --enable-comms=mpi-auto --prefix=/home/developer/GRID


CMD ["/bin/bash"]

