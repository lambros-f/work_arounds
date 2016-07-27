# PbSuite 14.7.14 and greater with new Blasr (>=5.3) versions

##Time spend for the work-around:

1 working day, mainly spent in figuring out the reason of the problem, trying different libraries, compiling, running tests etc etc.

##Issues:

- Test phage data do not run properly, you get errors, no correct completion of the job
- When running Pbjelly (Jelly.py) you will get a no gaps found error, or the result will be no different from the original assembly

##Work-around:

The problem is caused from the incompatibility of the blasr versions and the PBsuite scripts. More specifically, the new blasr version
5.3, is not accepting double dashed (--) options as the old ones and therefore it returns an error like "--nproc" not a valid option.

If you try to roll back to an very early version (earlier than 1.3.1), you usually run in to another problem, which is that the blasr output is scored
differently than what the Jelly script expects and considers all reads as not mapped to the assembly.

Therefore the work-around is basically, downloading blastr version earlier than 5.3 but more recent than 1.3.1.

I guess another option is diving in the PBsuite scripts, but this is very high risk.

##Steps

Step 1:

**Downloading the older Blasr version.**

It is difficult to get precompiled Blasr, and if you do sometimes it will not work, therefore you have to compile it yourself.
Getting the older source is somewhat tricky, since you have to download older branches from the Pacbio github repos. This is
how you do this:

  `git clone https://github.com/PacificBiosciences/blasr/ --recursive`
  
  `cd blasr`
  
  `git checkout remotes/origin/2015legacy`
  
  `make`
  

Once this is done your compiled blasr should be in the alignment/bin

Then do:

  `./blasr -version`

If everything was ok then the version should be 1.3.1 . Which is great.

*I have noticed that different blasr versions will give different results, therefore you
might want to look more in to other branches to get another version*

Here I assume that hdf5 is already installed, if not follow the instructions on
blasr.install.sh, which are the guidelines I have copied from the Pacbio repo.

Step 2:

**Run the test data**

Go to the PBsuite installation folder. There is a docs/jellyExample folder with test data.

Run the tests and check the results in the:
- mapping and support folders (especially check in the .gml file is empty)
- check the \"gap_fill_status.txt"\, if you get "nofillmetrics" something is wrong.

Step 3:

**Run your own data**

Run your own data and evaluate the result



## Other sources of information:

https://sourceforge.net/p/pb-jelly/discussion

https://github.com/PacificBiosciences/blasr/wiki/Step-by-step-blasr-installation-example
