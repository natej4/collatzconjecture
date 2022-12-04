#!/usr2/local/julia-1.8.2/bin/julia
#  Collatz Conjecture
#  Nate Jackson
#  CSC330 F22

#  Takes in two number from the command line, 
#  calculates the length of each number's collatz sequence,
#  then sorts on the lengths of the sequences and the integer values themselves
#  displaying only the 10 largest lengths
mutable struct parallel
    num::Int32
    length::Int32
end
# calculates length of collatz sequence for given number
function sequence(num)
    length = 0
    while num != 1
        if num % 2 == 0
            num /= 2;
        else
            num = num * 3 + 1
        end
        length += 1
    end
    return length
end
# bubble sort based on sequence length
function lengthSort(v::Array{parallel})
	# if duplicate length values, keep only smallest integer
    for i in 1:length(v)
        for j in 1:length(v)
            if v[i].num != v[j].num && v[i].length == v[j].length
                v[j].length = 0
            end
        end
    end

    for i in length(v)-1:-1:1
        for j in 1:i
            if v[j+1].length >= v[j].length
                temp = v[j+1].length
                v[j+1].length = v[j].length
                v[j].length = temp
                temp = v[j+1].num
                v[j+1].num = v[j].num
                v[j].num = temp
            end
        end
    end
end
# bubble sort based on integer values
function integerSort(v::Array{parallel})
    for i in length(v)-1:-1:1
        for j in 1:i
            if v[j+1].num >= v[j].num
                temp = v[j+1].num
                v[j+1].num = v[j].num
                v[j].num = temp
                temp = v[j+1].length
                v[j+1].length = v[j].length
                v[j].length = temp
            end
        end
    end
end

# Main
num1 = parse(Int32, ARGS[1])
num2 = parse(Int32, ARGS[2])
if num1 > num2
    temp = num1
    num1 = num2
    num2 = temp
end
v = Array{parallel, 1}(undef, 51)

# filling arrays, first nums, then sequence lengths
for i in num1:num2
    index = i-num1+1
    s = parallel(i, sequence(i))
    v[index] = s
end

lengthSort(v)
# now that arrays are sorted, keep only top 10 values
v_final = v[1:1:10]
println("Sorted based on sequence length:")
for i in 1:length(v_final)
    print(v_final[i].num)
    print("\t")
    println(v_final[i].length)
end

integerSort(v_final)
println("Sorted based on integer value:")
for i in 1:length(v_final)
    print(v_final[i].num)
    print("\t")
    println(v_final[i].length)
end