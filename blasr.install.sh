#
# Note : the example below builds blasr without pbbam libraries,
# so that --bam option is not supported.
# In order to build blasr which supports --bam option, please use pitchfork.
# https://github.com/PacificBiosciences/pitchfork
#
TOP=$(pwd)
#e.g. /home/username

# Create installation directory
mkdir -p blasr_install
cd blasr_install

# Bring and untar hdf5, if you don't have it
mkdir -p hdf5
cd hdf5
wget https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/bin/linux-centos6-x86_64-gcc447/hdf5-1.8.16-linux-centos6-x86_64-gcc447-shared.tar.gz
tar -zxvf hdf5-1.8.16-linux-centos6-x86_64-gcc447-shared.tar.gz
cd ..

# Clone and build blasr
git clone https://github.com/PacificBiosciences/blasr.git --recursive
cd blasr

./configure.py --shared --sub --no-pbbam HDF5_INCLUDE=${TOP}/blasr_install/hdf5/hdf5-1.8.16-linux-centos6-x86_64-gcc447-shared/include/ HDF5_LIB=${TOP}/blasr_install/hdf5/hdf5-1.8.16-linux-centos6-x86_64-gcc447-shared/lib

make configure-submodule

make build-submodule

make blasr

# After compilation, LD_LIBRARY_PATH is printed

# e.g.
LD_LIBRARY_PATH=${TOP}/blasr_install/blasr/libcpp/alignment:${TOP}/blasr_install/blasr/libcpp/hdf:${TOP}/blasr_install/blasr/libcpp/pbdata:${TOP}/blasr_install/hdf5/hdf5-1.8.16-linux-centos6-x86_64-gcc447-shared/lib/:

# It's necessary to export whatever it prints prior to blasr invocation, otherwise it will not run.
# Note ! When building on Mac, the name of the variable to export is DYLD_LIBRARY_PATH

# Finally
./blasr --version
# Note : prior to Blasr version 5.1 , use ./blasr -version (single dash)

# If you see this
#./blasr: error while loading shared libraries: libpbihdf.so: cannot open shared object file: No such file or directory
# Then
#export LD_LIBRARY_PATH=...  
# or, if building on Mac
#export DYLD_LIBRARY_PATH=...

# Verify blasr

./blasr --version
# it will print the Blasr version in format MajorVersion.SubVersion.SHA1 (first 7 characters of SHA1 hash) e.g
# blasr   5.1.c3b1d3e
# Note : prior to Blasr version 5.1 , use ./blasr -version (single dash)

# If there are any problems with the build due to your OS/compiler or any other incompatibilities, 
# please consider to use pitchfork
# https://github.com/PacificBiosciences/pitchfork
# which is our completely self-contained build environment 
