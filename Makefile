.SUFFIXES: .F o

FC=mpif90
LINKER=mpif90
MAX_NN=9
EXE_NAME=test

# Gfortran
FFLAGS = -O3 -m64 -ffree-line-length-none -fdefault-real-8 -fdefault-double-8 -fconvert=big-endian -ffree-form
LDFLAGS = -O3
CPPFLAGS = -D_MPI
CPPINCLUDES = -I.
FCINCLUDES = -I.

# Ifort
#FFLAGS = -real-size 64 -O3 -convert big_endian -FR
#CPPFLAGS = -D_MPI
#LDFLAGS = -O3
#CPPINCLUDES = -I.
#FCINCLUDES = -I.

OBJS = test_mpi.o level1.o level2.o level3.o level4.o

all: gen_lvl5 test.o
	$(LINKER) $(LDFLAGS) -o $(EXE_NAME) *.o

test.o: gen_lvl5 $(OBJS)

test_mpi.o:

level1.o: test_mpi.o level2.o gen_lvl5
level2.o: test_mpi.o level3.o gen_lvl5
level3.o: test_mpi.o level4.o gen_lvl5
level3.o: test_mpi.o gen_lvl5

gen_lvl5: test_mpi.o
	( rm -f level5_uses.inc level5_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%02d" $$ID`; \
		 echo "use level5_$$EXP" >> level5_uses.inc; \
		 echo -n "      call level5_" >> level5_calls.inc; \
		 echo -n "$$EXP" >> level5_calls.inc; \
		 echo "_test()" >> level5_calls.inc; \
		 cat level5_NN.F | sed "s/NN/$$EXP/g" > level5_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level5_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )

clean:
	rm -rf *.o *.mod *.inc $(EXE_NAME)
	(for ID in `seq 0 $(MAX_NN)`; do EXP=`printf "%02d" $$ID`; rm -f level5_$$EXP.F; done)

.F.o:
	rm -f $@ $*.mod
	$(FC) $(CPPFLAGS) $(FFLAGS) -c $*.F $(CPPINCLUDES) $(FCINCLUDES)

