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

OBJS = test_mpi.o level1.o

all: gen_lvl6 test.o
	$(LINKER) $(LDFLAGS) -o $(EXE_NAME) *.o

test.o: gen_lvl6 $(OBJS)

test_mpi.o:

level1.o: test_mpi.o gen_lvl2

gen_lvl2: test_mpi.o gen_lvl3
	( rm -f level2_uses.inc level2_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%03d" $$ID`; \
		 echo "use level2_$$EXP" >> level2_uses.inc; \
		 echo -n "      call level2_" >> level2_calls.inc; \
		 echo -n "$$EXP" >> level2_calls.inc; \
		 echo "_test()" >> level2_calls.inc; \
		 cat level2_NN.F | sed "s/NN/$$EXP/g" > level2_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level2_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )

gen_lvl3: test_mpi.o gen_lvl4
	( rm -f level3_uses.inc level3_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%03d" $$ID`; \
		 echo "use level3_$$EXP" >> level3_uses.inc; \
		 echo -n "      call level3_" >> level3_calls.inc; \
		 echo -n "$$EXP" >> level3_calls.inc; \
		 echo "_test()" >> level3_calls.inc; \
		 cat level3_NN.F | sed "s/NN/$$EXP/g" > level3_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level3_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )

gen_lvl4: test_mpi.o gen_lvl5
	( rm -f level4_uses.inc level4_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%03d" $$ID`; \
		 echo "use level4_$$EXP" >> level4_uses.inc; \
		 echo -n "      call level4_" >> level4_calls.inc; \
		 echo -n "$$EXP" >> level4_calls.inc; \
		 echo "_test()" >> level4_calls.inc; \
		 cat level4_NN.F | sed "s/NN/$$EXP/g" > level4_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level4_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )

gen_lvl5: test_mpi.o gen_lvl6
	( rm -f level5_uses.inc level5_calls.inc )
	( for ID in `seq 0 $(MAX_NN)`; \
	  do \
	     EXP=`printf "%03d" $$ID`; \
		 echo "use level5_$$EXP" >> level5_uses.inc; \
		 echo -n "      call level5_" >> level5_calls.inc; \
		 echo -n "$$EXP" >> level5_calls.inc; \
		 echo "_test()" >> level5_calls.inc; \
		 cat level5_NN.F | sed "s/NN/$$EXP/g" > level5_$$EXP.F; \
		 $(FC) $(CPPFLAGS) $(FFLAGS) -c level5_$$EXP.F $(CPPINCLUDES) $(FCINCLUDES); \
	  done )


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
	(for ID in `seq 0 $(MAX_NN)`; do EXP=`printf "%03d" $$ID`; rm -f level*_$$EXP.F; done)

.F.o:
	rm -f $@ $*.mod
	$(FC) $(CPPFLAGS) $(FFLAGS) -c $*.F $(CPPINCLUDES) $(FCINCLUDES)

