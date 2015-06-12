module level2
   use test_mpi
   use level3

   contains

   subroutine level2_test()
     write(0,*) ' In level2_test'
      call level3_test()
   end subroutine level2_test

end module level2
