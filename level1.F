module level1
  use test_mpi
#include "level2_uses.inc"

  contains

  subroutine level1_test()
     write(0,*) ' In level1_test'
#include "level2_calls.inc"
      call test_global_abort()
  end subroutine level1_test

end module level1
