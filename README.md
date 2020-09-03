# Grid-box

Centos8 based container to compile Grid libraries for LQCD

The container is meant to be run using "udocker" to avoid requiring root privileges if you use it in a multi-user HPC system.

udocker is available at:  https://github.com/indigo-dc/udocker. To install udocker:

curl https://raw.githubusercontent.com/indigo-dc/udocker/master/udocker.py > udocker  \
 chmod u+rx ./udocker \
 ./udocker install 

Grid-box is built using the lates release of Centos, enhanced with the development tools required to build, compile and execute GRID.
It includes as well the optional libraries used by the software package Grid (LIME, FFTW, HDF5 and LAPACK).
They have been placed under /opt/projects/Grid

INSTRUCTIONS:

1)  Create a container from the image as downloaded from Docker hub:
./udocker create --name=mygrid-box iscampos/grid-box

(mygrid-box is en example name, pick the name you like)

2)  Execute the container:
./udocker run mygrid-box /bin/bash  

will execute the container by providing a sort of chroot environment in a local directory of the user under $HOME/.udocker/containers/mygrid-box

The GRID software libraries compiled are available at: /home/developer/GRID
Sources are avaliable at: /opt/projects/GRID/SRC

Other extra (non-mandatory) libraries are available at: 
/opt/projects/HPF5, /opt/projects/LIME, /opt/projects/LAPACK and /opt/projects/FFTW


The grid-box has pre-installed openMPI as MPI implementation and has compiled GRID for them. 
If you want to use another one, you need to install it your self following usual procedures.  
Notice however that the environment variables  are by default pointing to OpenMPI as default. You need to change that.

If you make changes inside the container directory structure (e.g. installing additional software you find useful) and want to make a backup just in case.

1) First save the container status into a tar file:

./udocker export -o mygrid-box-v1.tar mygrid-box

2) Then create the new image:

./udocker import mygrid-box-v1.tar mygrid-box-v1





