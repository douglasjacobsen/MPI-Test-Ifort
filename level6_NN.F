module level6_NN
   use test_mpi

   contains

   subroutine level6_NN_test()
      write(0,*) ' In level6_NN_test'
      call test_global_abort()
   end subroutine level6_NN_test
end module level6_NN
