package main

import (
	"fmt"
	"os"
	"strconv"
)

type Parallel struct {
	num int
	length int
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
	v := []*Parallel{}
	// var v  []Parallel
	
	createArray(v, num1, num2)
	fmt.Println(len(v))
	for i := 0; i < len(v); i++ {
		length := sequence(v[i].num)
		v[i].length = length
		fmt.Println(v[i].num," ", v[i].length)
	}
}

func createArray(v []*Parallel,num1, num2 int){
	if num1 > num2 {
		temp := num1
		num1 = num2
		num2 = temp
	}

	for i := num1; i <= num2; i++ {
		// pair := new(Parallel)
		// pair.num = i
		// fmt.Println(i)
		pair := Parallel{
			num: i,
			length: 0,
		}
		v = append(v, &pair)
	}
}

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