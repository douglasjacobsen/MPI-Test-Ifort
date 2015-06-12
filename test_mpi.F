module test_mpi

include 'mpif.h'

   contains

   subroutine test_global_abort()

      integer :: mpi_errcode, mpi_ierr

      call MPI_Abort(MPI_COMM_WORLD, mpi_errcode, mpi_ierr)

   end subroutine test_global_abort

end module test_mpi
