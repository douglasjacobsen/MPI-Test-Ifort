module level3
   use test_mpi
   use level4

   contains

   subroutine level3_test()
     write(0,*) ' In level3_test'
      call level4_test()
      call test_global_abort()
   end subroutine level3_test

end module level3
