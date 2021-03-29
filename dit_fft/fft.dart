import './complex.dart'; // Complex number handler - pub.dev/packages/complex
import 'dart:math'; // just for `pi`

void main() {
  // ⸻⸻⸻⸻
  // * Preferences
  // ⸻⸻⸻⸻
  int precision = 3; // Calculate upto ${digits} of decimal
  String imgF = 'i('; // format the output to your liking
  String imgB = ')'; // a + ib -> a + $imgF b $imgB
  String separator = '   ⸻⸻>   '; // x(0) ⸻> X(0)

  // ⸻⸻⸻⸻
  // * Input signal
  // ⸻⸻⸻⸻
  // Complex(a, b) == a + ib
  List<Complex> f = [
    Complex(0.5, 0),
    Complex(0.5, 0),
    Complex(0.5, 0),
    Complex(0.5, 0),
    Complex(0.0, 0), // intentionally selected 5 elements only -> padding safety
  ];

  // ⸻⸻⸻⸻⸻⸻⸻⸻⸻
  // * FFT -> Adds padding if necessairy
  // ⸻⸻⸻⸻⸻⸻⸻⸻⸻
  if (isPowerOfTwo(f.length)) {
    List<Complex> f_FFT = FFT(f);
    printComplex(f, f_FFT, precision, imgF, imgB, separator);
  } else {
    f = padWithZeros(f);
    List<Complex> f_FFT = FFT(f);
    printComplex(f, f_FFT, precision, imgF, imgB, separator);
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function to check 2^n form
// ⸻⸻⸻⸻⸻⸻⸻⸻
bool isPowerOfTwo(int num) {
  // 8 = 1000
  // 7 = 0111
  // & = 0000
  return (num & num - 1 == 0) ? true : false;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function to pad signal with zeros
// ⸻⸻⸻⸻⸻⸻⸻⸻
List<Complex> padWithZeros(List<Complex> f) {
  int N = f.length;
  // 2 ^ (log(N)/log(2)) -> nearest 2^n
  int nextPowerOfTwo = pow(2, (log(N) / log(2)).ceil()).toInt();
  int paddingReqd = nextPowerOfTwo - N;

  return f + List<Complex>.filled(paddingReqd, Complex(0, 0));
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Twiddle Factor Generator W_N^{k}
// ⸻⸻⸻⸻⸻⸻⸻⸻
Complex W(int k, int N) {
  Complex W = Complex(0, -2 * pi * k / N).exp();
  return W;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Radix2 FFT Algorithm
// ⸻⸻⸻⸻⸻⸻⸻⸻
List<Complex> FFT(List<Complex> f) {
  int N = f.length; // length of half split
  if (N <= 1) {
    // Only 1 element exists => further split is not possible
    return f;
  }

  // Init Lists for even and odd half splits
  List<Complex> halfEven = [];
  List<Complex> halfOdd = [];

  // Get even elements from {super:f}
  for (int i = 0; i < N; i += 2) {
    halfEven.add(f[i]);
  }

  // Get odd elements from {super:f}
  for (int i = 1; i < N; i += 2) {
    halfOdd.add(f[i]);
  }

  // Iterative Radix2 FFT [super:f] -> [f:even][f:odd]
  // Decimation
  List<Complex> even = FFT(halfEven);
  List<Complex> odd = FFT(halfOdd);

  // Init currentFFT = [0+0i, 0+0i, ... , 0+0i];
  List<Complex> currentFFT = List<Complex>.filled(N, Complex(0, 0));

  // NOTE: in Dart, (number ~/ 2) == (number / 2).toInt
  int d = N ~/ 2; // dissipated length to gain advantage of W_N -> W_N/2

  for (int k = 0; k < d; k++) {
    Complex W_kN = W(k, N); // Get W from twiddle factor generator

    /* FFT by dissipation
          X(k +  0 ) = G[k] + W * H[k]
          X(k + N/2) = G[k] - W * H[k]
    */
    currentFFT[k + 0] = even[k] + W_kN * odd[k];
    currentFFT[k + d] = even[k] - W_kN * odd[k];
  }

  // Return dissipated FFT to iterative caller, or final FFT to main()
  return currentFFT;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function to print output
// ⸻⸻⸻⸻⸻⸻⸻⸻
void printComplex(List<Complex> f, List<Complex> f_FFT, int precision,
    String styleF, String styleB, String separator) {
  String message = '';
  for (int i = 0; i < f.length; i++) {
    String a = f[i].real.toStringAsFixed(precision);
    String b = f[i].imaginary.toStringAsFixed(precision);
    String x = f_FFT[i].real.toStringAsFixed(precision);
    String y = f_FFT[i].imaginary.toStringAsFixed(precision);

    // Pre FFT
    message = 'x($i) = ';
    !a.startsWith('-') ? message += ' $a ' : message += '$a ';
    if (!b.startsWith('-')) {
      message += '+ $styleF$b$styleB';
    } else {
      b = b.substring(1);
      message += '- $styleF$b$styleB';
    }

    // FFT Symbol
    message += separator;

    // Post FFT
    message += 'X($i) = ';
    !x.startsWith('-') ? message += ' $x ' : message += '$x ';
    if (!y.startsWith('-')) {
      message += '+ $styleF$y$styleB';
    } else {
      y = y.substring(1);
      message += '- $styleF$y$styleB';
    }

    // Print
    print(message);
  }
}
