// Function types must be declared
fn print_arr(a: &[i32]) -> () {
  for i in a {
    print!("{} ", i);
  }
  println!("");
}

fn swap(a: &mut[i32], i: usize, j: usize) -> () {
  let tmp = a[i];
  a[i] = a[j];
  a[j] = tmp;
}

fn partition(arr: &mut[i32], start: usize, end: usize) -> usize {
    if end <= start {
        return end;
    }

    let mut i = start;
    let pivot = end;

    for j in start..end {
 //       println!("{}", j);
        if arr[j] <= arr[pivot] {
            swap(arr, i, j);
            i = i + 1;
        }
    }

    swap(arr, i, end);
//    print_arr(&arr[..]);

    return i;
}

fn quick_sort(arr: &mut[i32], start: usize, end: usize) {
    if start > end {
        return;
    }
    let index = partition(arr, start, end);
    if index == 0 {
        return;
    }
    quick_sort(arr, start, index - 1);
    quick_sort(arr, index + 1, end);
}

fn main() {
    let mut arr = [9, 4, 13, 2, 22, 17, 8, 9, 1, 100, 32, 64, 128, 0, -1 , -2, -100, -100, 20, 26];

    let end = arr.len() - 1; 

    print_arr(&arr[..]);
    quick_sort(&mut arr[..], 0, end);
    print_arr(&arr[..]);
}
