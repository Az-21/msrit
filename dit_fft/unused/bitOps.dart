import '../complex.dart';
import 'dart:math';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: create twiddle list
// ⸻⸻⸻⸻⸻⸻⸻⸻
List<Complex> TwiddleFactorList(int bits) {
  // Vars
  int N = bits ~/ 2; // ~/ => (x/2).toInt()
  List<Complex> W = [];

  for (int k = 0; k < N; k++) {
    Complex W_k = Complex(0, -2 * pi * k / N).exp();
    W.add(W_k);
  }

  return W;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: count bits in (number)_10
// ⸻⸻⸻⸻⸻⸻⸻⸻
int countBits(int num_10) {
  int bits = 0;
  while (num_10 != 0) {
    bits++;
    num_10 >>= 1;
  }
  return bits;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: bit reversal
// ⸻⸻⸻⸻⸻⸻⸻⸻
List<int> bitReversal(int bits) {
  // Vars
  List<int> bitReversed = [0];
  List<int> upper = [];
  List<int> lower = [];

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Bit reversal algorithm
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  /*
      * n0 = [0]
        1. upper = [0] * 2
        2. lower = [upper] + 1
        3. upper + lower
        4. n1 = [0,1]
      * n1 = [0, 1]
      * n2 = [0, 2, 1, 3]
      * n3 = [0, 4, 2, 6, 1, 5, 3, 7] ... and so on
  */
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  for (int i = 0; i < bits; i++) {
    // upper = [n] * 2
    upper = bitReversed.map((element) => element * 2).toList();
    // lower = [upper] + 1
    lower = upper.map((element) => element + 1).toList();
    bitReversed = upper + lower;
  }

  // Return
  return bitReversed;
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: bit sorted
// ⸻⸻⸻⸻⸻⸻⸻⸻
List<Complex> bitRevSorted(List<Complex> li) {
  // Number of bits in given discrete points
  // 8 points -> [0:7] -> (7)_10 = (111)_2
  int bits = countBits(li.length - 1);

  // Calling bitReversal() to create sorting map
  // at bits = 3 -> fftMap = [0, 4, 2, 6, 1, 5, 3, 7]
  List<int> fftMap = bitReversal(bits);

  // Zipping FFT sorting map with input (discrete points)
  // {0: n0, 4: n1, 2: n3, ... , 7: n7}
  final Map mapping = {for (int i = 0; i < li.length; i++) fftMap[i]: li[i]};

  // Sort according to index
  // [0, 4, 2, 6, 1, 5, 3, 7] -> [0, 1, 2, 3, 4, 5, 6, 7]
  // Since `mapping` created a "zip", the discrete points also sort accordingly
  fftMap.sort();
  li = [for (int number in fftMap) mapping[number]];

  return li;
}
