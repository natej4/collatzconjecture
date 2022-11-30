! Collatz Conjecture
! Nate Jackson
! CSC330 F22

! Takes in two number from the command line, 
! calculates the length of each number's collatz sequence,
! then sorts on the lengths of the sequences and the integer values themselves
! displaying only the 10 largest lengths

! RECURSIVE VERSION

program collatz
    implicit none
    type parallel
        integer :: num
        integer :: length
    end type parallel
    integer :: i, num1, num2, count=0, temp, size, al=10,  psize
    type(parallel), dimension(:), allocatable :: vals
    type(parallel), dimension(10) :: vals_final
    character(len= 32) :: arg

    call get_command_argument(1, arg)
    read(arg,*) num1
    call get_command_argument(2, arg)
    read(arg,*) num2
    
    if (num1 > num2) then
        temp = num1
        num1 = num2
        num2 = temp
    endif

    !minimum array allocation of 10
    if (num2-num1>al) then
        al = num2-num1
    endif
    allocate(vals(al))
    call createArray (vals, num1, num2, size)

    ! find sequence lengths for each number in array
    do i = 1,size
        temp = vals(i)%num
        call sequence (temp, count)
        vals(i)%length = count
        count = 0
    enddo
    
    call length_sort(vals, size)
    ! keep only top 10 values
    vals_final = reshape(vals, (/10/))

    ! handling printing if array is smaller than 10
    if (size > 10) then
        psize = 10
    else
        psize = size
    endif

    print *, "Sorted based on sequence length: "
    do i = 1, psize
        print *, vals_final(i)%num, " ", vals_final(i)%length
    enddo

    call integer_sort(vals_final, psize)
    print *, " Sorted based on integer size: "
    do i = 1, psize
        print *, vals_final(i)%num, " ", vals_final(i)%length
    enddo
    
    deallocate (vals)

    contains

!fills array with numbers between entered values
subroutine createArray(vals, x, y, size)
    implicit none

    integer :: x,y,size,n
    type(parallel), dimension(214748364), intent(out) :: vals

    size = 1
    do n = x,y
        vals(size)%num = n
        size = size + 1
    end do
    size = size - 1

end subroutine createArray

!calculates the length of the collatz sequence of a number recursively
recursive subroutine sequence(number, count)
    implicit none
    integer :: number, count

    if (number == 1) then
        return
    endif

    if (modulo(number, 2) == 0) then
        number = number / 2
    else
        number = number * 3 + 1
    endif
    count = count + 1
    call sequence(number, count)
    
end subroutine sequence

! adapted from https://www.mjr19.org.uk/IT/sorts/sorts.f90
! bubble sort implementation, sorts parallel arrays based on length value
! if any numbers have the same sequence length, the smallest number is kept
! descending
subroutine length_sort(array, size)
    implicit none
    integer :: i,j,last, temp, temp2, size
    type(parallel), dimension(214748364) :: array

    last=size
    
    do i = 1, size
        do j = 1, size
            if (array(i)%num /= array(j)%num .and. array(i)%length == array(j)%length) then
                array(j)%length = 0
            endif
        enddo
    enddo
    do i=last-1,1,-1
        do j=1,i
            if (array(j+1)%length >= array(j)%length) then
                temp=array(j+1)%length
                array(j+1)%length=array(j)%length
                array(j)%length=temp
                    temp2=array(j+1)%num
                    array(j+1)%num=array(j)%num
                    array(j)%num=temp2
            endif
        enddo
    enddo

end subroutine length_sort

! bubble sorts the truncated list by the integer values, descending
subroutine integer_sort(vals, size)
    implicit none
    integer :: i,j,last, temp, temp2, size
    type(parallel), dimension(10) :: vals
  
    last=size
    do i=last-1,1,-1
       do j=1,i
          if (vals(j+1)%num >= vals(j)%num) then
              temp=vals(j+1)%num
              vals(j+1)%num=vals(j)%num
              vals(j)%num=temp
                  temp2=vals(j+1)%length
                  vals(j+1)%length=vals(j)%length
                  vals(j)%length=temp2
          endif
       enddo
    enddo
  end subroutine integer_sort

end program collatz