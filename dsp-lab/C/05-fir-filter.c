#include <math.h>
#include <stdio.h>
#define pi 3.14159265359

// FIR | 3 Window Types | 4 Filter Types | 12 P&Cs

/* --- Window functions --- */
// wType: 0 = rect, 1 = hanning, 2 = hamming
double wn(int wType, int n, int N) {
  switch (wType) {
  case 0:
    return 1;
  case 1:
    return 0.5 * (1 - cos(2 * n * pi / (N - 1)));
  case 2:
    return 0.54 - 0.46 * cos(2 * n * pi / (N - 1));
  default:
    printf("Unexpected window type");
    return 0;
    break;
  }
}

/* --- Filter functions --- */
// fType: 0 = LPF, 1 = HPF, 2 = BPF, 3 = BSF
double hdn(int fType, double wc1, double wc2, int n, int tao) {
  switch (fType) {
  case 0:
    if (n != tao)
      return sin(wc1 * (n - tao)) / (pi * (n - tao));
    return wc1 / tao;
  case 1:
    if (n != tao)
      return (sin(pi * (n - tao)) - sin(wc1 * (n - tao))) / (pi * (n - tao));
    return (pi - wc1) / tao;
  case 2:
    if (n != tao)
      return (sin(wc2 * (n - tao)) - sin(wc1 * (n - tao))) / (pi * (n - tao));
    return (wc2 - wc1) / tao;
  case 3:
    if (n != tao)
      return (sin(pi * (n - tao)) - sin(wc2 * (n - tao)) +
              sin(wc1 * (n - tao))) /
             (pi * (n - tao));
    return (pi - wc2 + wc1) / tao;
  default:
    printf("Unexpected filter type");
    return 0;
    break;
  }
}

int main() {
  // Input values
  const double fp[] = {50};     // passband frequency(Hz)
  const double fs[] = {10};     // stopband frequency(Hz)
  const double sampling = 1000; // sampling frequency(Hz) | Warning! H[256]
  const double rs = 0.01;       // stopband ripple

  // Inferences
  const filterBands = sizeof(fp) / sizeof(fp[0]); // 1 = pass, 2 = band
  double wp[2] = {0, 0};
  double ws[2] = {0, 0};
  for (int i = 0; i < filterBands; i++) {
    wp[i] = 2 * pi * fp[i] / sampling;
    ws[i] = 2 * pi * fs[i] / sampling;
  }
  const double As = -20 * log(rs);        // attenuation
  const double tw = fabs(wp[0] - ws[0]);  // transition width
  const double wc1 = (wp[0] + ws[0]) / 2; // cutoff frequency 1
  const double wc2 = (wp[1] + ws[1]) / 2; // cutoff frequency 2

  /* --- Window type --- */
  int wType; // 0 = rect, 1 = hanning, 2 = hamming
  int N = 0;
  if (As <= 21) {
    printf("Rectangular Window | ");
    N = ceil((4 * pi / tw) - 1);
    wType = 0;
  } else if (As > 21 && As < 44) {
    printf("Hanning Window | ");
    N = ceil(8 * pi / tw);
    wType = 1;
  } else {
    printf("Hamming Window | ");
    N = ceil(8 * pi / tw);
    wType = 2;
  }

  /* --- Filter type --- */
  int fType; // 0 = LPF, 1 = HPF, 2 = BPF, 3 = BSF
  if (filterBands == 1 && wp < ws) {
    printf("Lowpass Filter\n\n");
    fType = 0;
  } else if (filterBands == 1 && wp > ws) {
    printf("Highpass Filter\n\n");
    fType = 1;
  } else if (filterBands == 2 && wp > ws) {
    printf("Bandpass Filter\n\n");
    fType = 2;
  } else {
    printf("Bandstop Filter\n\n");
    fType = 3;
  }

  /* --- Tao --- */
  if (N % 2 == 0)
    N++;
  const int tao = (N - 1) / 2;
  printf("N = %d, tao = %d, tw = %f\n\n", N, tao, tw);

  /* --- H(n) --- */
  double H[256]; // WARNING: increase this value for high frequencies
  for (int n = 0; n < N; n++) {
    H[n] = wn(wType, n, N) * hdn(fType, wc1, wc2, n, tao);
    printf("H(%d) = %0.10f\n", n, H[n]);
  }
  return 0;
}
