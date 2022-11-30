use std::env;
struct Parallel {
    num: u32,
    length: u32
}
fn main() {
    let args: Vec<String> = env::args().collect();
    let num1 = &args[1].parse::<u32>().unwrap();
    let num2 = &args[2].parse::<u32>().unwrap();
    let mut v : Vec<Parallel> = Vec::new();
    let mut size: u32 = 1;
    
    create_array(&mut v, *num1, *num2, &mut size);

    for p in 0..v.len() {
        sequence_recursed(v[p].num, &mut v[p].length);
    }

    length_sort(&mut v);
    v.truncate(10);
    println!("Sorted based on sequence length:");
    for i in 0..v.len() {
        println!("{}\t{}",v[i].num,v[i].length);
    }

    integer_sort(&mut v);
    println!("Sorted based on integer size:");
    for i in 0..v.len() {
        println!("{}\t{}",v[i].num,v[i].length);
    }

}

fn create_array(v:&mut Vec<Parallel>, mut num1: u32, mut num2: u32, size:&mut u32) {
    if num1 > num2 {
        let temp = num1;
        num1 = num2;
        num2 = temp;
    }

    for n in num1..num2+1 {
        v.push(Parallel{num:n, length:0});
        *size += 1;
    }
    *size -= 1;
}

fn sequence_recursed(mut num:u32, length:&mut u32){
    if num == 1 {
        return
    }
    
    if num % 2 == 0 {
        num /= 2;
    }
    else {
        num = num * 3 + 1;
    }
    *length += 1;
    sequence_recursed(num, length);
    
}

fn length_sort(v:&mut Vec<Parallel>){
    for _i in 0..v.len() {
        for j in 0..v.len() {
            if v[_i].num != v[j].num && v[_i].length == v[j].length {
                v[j].length = 0;
            }
        }
    }

    for i in (0..v.len()).rev() {
        for j in 0..i {
            if v[j+1].length >= v[j].length {
                let temp = v[j+1].length;
                v[j+1].length = v[j].length;
                v[j].length = temp;
                let temp2 = v[j+1].num;
                v[j+1].num = v[j].num;
                v[j].num = temp2;
            }
        }
    }
}

fn integer_sort(v:&mut Vec<Parallel>){
    for i in (0..v.len()).rev() {
        for j in 0..i {
            if v[j+1].num >= v[j].num {
                let temp = v[j+1].num;
                v[j+1].num = v[j].num;
                v[j].num = temp;
                let temp2 = v[j+1].length;
                v[j+1].length = v[j].length;
                v[j].length = temp2;
            }
        }
    }
}
