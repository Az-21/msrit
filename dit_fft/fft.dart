import 'dart:math';
import './complex.dart';

void main() {
  List<Complex> f = [
    Complex(1, 0),
    Complex(1, 0),
    Complex(1, 0),
    Complex(1, 0),
  ];

  List<Complex> FFT(List<Complex> f) {
    int N = f.length;
    if (N <= 1) {
      return f;
    }

    List<Complex> selectedEven = [];
    List<Complex> selectedOdd = [];
    for (int i = 0; i < N; i += 2) {
      selectedEven.add(f[i]);
    }
    for (int i = 1; i < N; i += 2) {
      selectedOdd.add(f[i]);
    }
    //
    List<Complex> even = FFT(selectedEven);
    List<Complex> odd = FFT(selectedOdd);

    // List<Complex> temp = [];
    List<Complex> temp = List<Complex>.filled(N, Complex(0, 0));

    for (int k = 0; k < N ~/ 2; k++) {
      Complex W_kN = W(k, N);
      temp[k] = even[k] + W_kN * odd[k];
      temp[k + N ~/ 2] = even[k] - W_kN * odd[k];
    }

    return temp;
  }

  print(FFT(f));
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Twiddle Factor
// ⸻⸻⸻⸻⸻⸻⸻⸻
Complex W(int k, int N) {
  // Twiddle factor: W_N^{k}
  Complex W = Complex(0, -2 * pi * k / N).exp();
  return W;
}
