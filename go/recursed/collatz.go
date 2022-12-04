package main

import (
	"fmt"
	"os"
	"strconv"
)

type Parallel struct {
	nums []int
	lengths []int
}

func main(){
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
	// nums := []int{}
	// lengths := []int{}
	var v  Parallel
	length := 0
	
	createArray(&v, num1, num2)
	for i := 0; i < len(v.nums); i++ {
		length_to_add := sequenceRecursed(v.nums[i], length)
		v.lengths = append(v.lengths, length_to_add)
		// fmt.Println(v.nums[i],"	", v.lengths[i])
	}

	lengthSort(&v)
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

func sequenceRecursed(num, length int) int{
	temp := num
	// length := 0
	if num == 1 {
		return length
	}
	if temp % 2 == 0 {
		temp /= 2
	} else {
		temp = temp * 3 + 1
	}
	length += 1
	return sequenceRecursed(temp, length)
}

func lengthSort(v *Parallel){
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