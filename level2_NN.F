module level2_NN
   use test_mpi
#include "level3_uses.inc"

   contains

   subroutine level2_NN_test()
      write(0,*) ' In level2_NN_test'
#include "level3_calls.inc"
      call test_global_abort()
   end subroutine level2_NN_test
end module level2_NN
