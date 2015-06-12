module level1
  use test_mpi
  use level2

  contains

  subroutine level1_test()
     write(0,*) ' In level1_test'
     call level2_test()
  end subroutine level1_test

end module level1
