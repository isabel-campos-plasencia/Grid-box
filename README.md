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

The container does not include the sources of GRID, those are to be downloaded from:

https://github.com/paboyle/Grid

and uncompressed to a local directory from the user $GRID_SOURCE.


INSTRUCTIONS:

1)  Create a container from the image as downloaded from Docker hub:
./udocker create --name=mygrid-box iscampos/grid-box

(mygrid-box is en example name, pick the name you like)

2)  Execute the container:
./udocker run -v $GRID_SOURCE  mygrid-box  

will execute the container by providing a sort of chroot environment in a local directory of the user under $HOME/.udocker/containers/mygrid-box

The directory $GRID_SOURCE will be available inside this environment. 

Inside the environment you can "cd $GRID_SOURCE" and follow the instructions of GRID. 

The grid-box has pre-installed openMPI as MPI implementation. If you want to use another one, you need to install it your self following usual procedures. 
Notice however that the environment variables are by default pointing to OpenMPI as default. You need to change that.





