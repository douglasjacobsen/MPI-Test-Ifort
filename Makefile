.SUFFIXES: .F o

FC=mpif90
LINKER=mpif90
MAX_NN=200
EXE_NAME=test

# Gfortran
# FFLAGS = -O3 -m64 -ffree-line-length-none -fdefault-real-8 -fdefault-double-8 -fconvert=big-endian -ffree-form
# LDFLAGS = -O3
# CPPFLAGS = -D_MPI
# CPPINCLUDES = -I.
# FCINCLUDES = -I.

# Ifort
FFLAGS = -real-size 64 -O3 -convert big_endian -FR
CPPFLAGS = -D_MPI
LDFLAGS = -O3
CPPINCLUDES = -I.
FCINCLUDES = -I.

OBJS = test_mpi.o level1.o level2.o level3.o level4.o level5.o

all: gen_lvl6 test.o
	$(LINKER) $(LDFLAGS) -o $(EXE_NAME) *.o

test.o: gen_lvl6 $(OBJS)

test_mpi.o:

level1.o: test_mpi.o level2.o gen_lvl6
level2.o: test_mpi.o level3.o gen_lvl6
level3.o: test_mpi.o level4.o gen_lvl6
level4.o: test_mpi.o level5.o gen_lvl6
level5.o: test_mpi.o gen_lvl6

gen_lvl6: test_mpi.o
	( rm -f level6_uses.inc level6_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%03d" $$ID`; \
		 echo "use level6_$$EXP" >> level6_uses.inc; \
		 echo -n "      call level6_" >> level6_calls.inc; \
		 echo -n "$$EXP" >> level6_calls.inc; \
		 echo "_test()" >> level6_calls.inc; \
		 cat level6_NN.F | sed "s/NN/$$EXP/g" > level6_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level6_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )

clean:
	rm -rf *.o *.mod *.inc $(EXE_NAME)
	(for ID in `seq 0 $(MAX_NN)`; do EXP=`printf "%03d" $$ID`; rm -f level6_$$EXP.F; done)

.F.o:
	rm -f $@ $*.mod
	$(FC) $(CPPFLAGS) $(FFLAGS) -c $*.F $(CPPINCLUDES) $(FCINCLUDES)

