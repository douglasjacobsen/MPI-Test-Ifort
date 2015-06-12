module level4_NN
   use test_mpi
#include "level5_uses.inc"

   contains

   subroutine level4_NN_test()
      write(0,*) ' In level4_NN_test'
#include "level5_calls.inc"
      call test_global_abort()
   end subroutine level4_NN_test
end module level4_NN
