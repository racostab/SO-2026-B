! fork.f90
program main
    use :: unix
    implicit none
    integer :: i, pid, rc

    pid = c_fork()

    if (pid < 0) then

        ! Fork failed.
        call c_perror('fork()' // c_null_char)

    else if (pid == 0) then

        ! Child process.
        print '("este es el hijo")'

        call c_exit(0)

    else

        print '("este es el padre")'

    end if
end program main
