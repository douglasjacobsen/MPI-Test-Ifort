module level5
   use test_mpi
#include "level6_uses.inc"

   contains

   subroutine level5_test()
      write(0,*) ' In level5_test'

#include "level6_calls.inc"
      call test_global_abort()
   end subroutine level5_test

end module level5
