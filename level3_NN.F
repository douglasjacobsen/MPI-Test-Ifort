module level3_NN
   use test_mpi
#include "level4_uses.inc"

   contains

   subroutine level3_NN_test()
      write(0,*) ' In level3_NN_test'
#include "level4_calls.inc"
      call test_global_abort()
   end subroutine level3_NN_test
end module level3_NN
