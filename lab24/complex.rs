struct Complex { real: i32, imaginary: i32 }

//fn add_complex(c1: Complex, c2: Complex) -> Complex {
fn add_complex(c1: &Complex, c2: &Complex) -> Complex {
  let r = c1.real + c2.real;
  let i = c1.imaginary + c2.imaginary;
  return Complex { real: r, imaginary: i };
}

fn square_complex_inplace(c: &mut Complex) {
  let r = c.real * c.real - c.imaginary * c.imaginary;
  let i = c.real * c.imaginary + c.imaginary * c.real;
  c.real = r;
  c.imaginary = i;
}

fn main() {
  let cmplx1 = Complex { real: 7, imaginary: 2 };
  let cmplx2 = Complex { real: 3, imaginary: 1 };
  //let ans = add_complex(cmplx1, cmplx2);  // No issues, unless we use cmplx1 or cmplx2 later
  let mut ans = add_complex(&cmplx1, &cmplx2);

  println!("The answer is {}+{}i", ans.real, ans.imaginary);
  println!("{}+{}i + {}+{}i = {}+{}i",
    cmplx1.real, cmplx1.imaginary,
    cmplx2.real, cmplx2.imaginary,
    ans.real, ans.imaginary);

  square_complex_inplace(&mut ans);
  println!("The answer squared is {}+{}i", ans.real, ans.imaginary);
}

