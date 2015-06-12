module level4
   use test_mpi
   use level5

   contains

   subroutine level4_test()
      write(0,*) ' In level4_test'
      call level5_test()
      call test_global_abort()
   end subroutine level4_test

end module level4
