package main
// Collatz Conjecture
// Nate Jackson
// CSC330 F22

// Takes in two number from the command line, 
// calculates the length of each number's collatz sequence,
// then sorts on the lengths of the sequences and the integer values themselves
// displaying only the 10 largest lengths
import (
	"fmt"
	"os"
	"strconv"
)
//struct of two parallel arrays
//could not do array of structs like in other languages because of
// the way go does pointers, couldn't make it work
// but this works just as well
type Parallel struct {
	nums []int
	lengths []int
}

func main(){
	//command line input
	num1, err1 := strconv.Atoi(os.Args[1])
	if err1 != nil {
		panic(err1)
	}
	num2, err2 := strconv.Atoi(os.Args[2])
	if err2 != nil {
		panic(err2)
	}
	if num1 > num2 {
		temp := num1
		num1 = num2
		num2 = temp
	}
	var v  Parallel

	// filling arrays, first nums, then sequence lengths
	createArray(&v, num1, num2)
	for i := 0; i < len(v.nums); i++ {
		length := sequence(v.nums[i])
		v.lengths = append(v.lengths, length)
	}

	lengthSort(&v)
	// now that arrays are sorted, keep only top 10 values
	v.nums = v.nums[0:10]
	v.lengths = v.lengths[0:10]
	fmt.Println("Sorted based on sequence length:")
	for i := 0; i < len(v.nums); i++{
		fmt.Println(v.nums[i],"	", v.lengths[i])
	}

	integerSort(&v)
	fmt.Println("Sorted based on integer size:")
	for i := 0; i < len(v.nums); i++{
		fmt.Println(v.nums[i],"	", v.lengths[i])
	}

}

func createArray(v *Parallel,num1, num2 int){

	for i := num1; i <= num2; i++ {
		v.nums = append(v.nums, i)
	}
}
//calculates length of collatz sequence for given number
func sequence(num int) int{
	temp := num
	length := 0
	for temp != 1 {
		if temp % 2 == 0 {
			temp /= 2
		} else {
			temp = temp * 3 + 1
		}
		length += 1
	}
	return length
}
// bubble sort of both arrays in struct
func lengthSort(v *Parallel){
	// if duplicate length values, keep only smallest integer
	for i := 0; i < len(v.nums); i++ {
		for j := 0; j < len(v.nums); j++ {
			if v.nums[i] != v.nums[j] && v.lengths[i] == v.lengths[j] {
				v.lengths[j] = 0
			}
		}
	}

	for i := len(v.nums)-1; i >= 0; i-- {
		for j := 0; j < i; j++ {
			if v.lengths[j+1] >= v.lengths[j] {
				temp := v.lengths[j+1]
				v.lengths[j+1] = v.lengths[j]
				v.lengths[j] = temp
				temp = v.nums[j+1]
				v.nums[j+1] = v.nums[j]
				v.nums[j] = temp
			}
		} 
	}
}
//bubble sort based on integer values
//will only ever sort 10 valuess
func integerSort(v *Parallel){
	for i := len(v.nums)-1; i >= 0; i-- {
		for j := 0; j < i; j++ {
			if v.nums[j+1] >= v.nums[j] {
				temp := v.nums[j+1]
				v.nums[j+1] = v.nums[j]
				v.nums[j] = temp
				temp = v.lengths[j+1]
				v.lengths[j+1] = v.lengths[j]
				v.lengths[j] = temp
			}
		} 
	}
}