import './complex.dart'; // Complex number handler - pub.dev/packages/complex
import 'dart:math'; // just for `pi`

void main() {
  // Complex(a, b) === a + ib

  // ⸻⸻⸻⸻
  // * Input signal
  // ⸻⸻⸻⸻
  List<Complex> f = [
    Complex(1, 0),
    Complex(1, 0),
    Complex(2, 0),
    Complex(1, 0),
  ];

  // ⸻⸻
  // * FFT
  // ⸻⸻
  print(FFT(f));
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
  // Dissimation
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
