module level4
   use test_mpi
#include "level5_uses.inc"

   contains

   subroutine level4_test()
      write(0,*) ' In level4_test'

#include "level5_calls.inc"
   end subroutine level4_test

end module level4
