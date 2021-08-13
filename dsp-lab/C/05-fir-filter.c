#include <math.h>
#include <stdio.h>
#define pi 3.14159265359

// FIR | 3 Window Types | 4 Filter Types | 12 P&Cs

/* --- Window functions --- */
double wnRectangular() { return 1; }
double wnHanning(int n, int N) { return 0.5 * (1 - cos(2 * n * pi / (N - 1))); }
double wnHamming(int n, int N) {
  return 0.54 - 0.46 * cos(2 * n * pi / (N - 1));
}

/* --- Window functions --- */
double hdnLPF(double wc, int n, int tao) {
  if (n != tao)
    return sin(wc * (n - tao)) / (pi * (n - tao));
  return wc / tao;
}
double hdnHPF(double wc, int n, int tao) {
  if (n != tao)
    return (sin(pi * (n - tao)) - sin(wc * (n - tao))) / (pi * (n - tao));
  return (pi - wc) / tao;
}
double hdnBPF(double wc1, double wc2, int n, int tao) {
  if (n != tao)
    return (sin(wc2 * (n - tao)) - sin(wc1 * (n - tao))) / (pi * (n - tao));
  return (wc2 - wc1) / tao;
}
double hdnBSF(double wc1, double wc2, int n, int tao) {
  if (n != tao)
    return (sin(pi * (n - tao)) - sin(wc2 * (n - tao)) + sin(wc1 * (n - tao))) /
           (pi * (n - tao));
  return (pi - wc2 + wc1) / tao;
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
  int tao = (N - 1) / 2;
  printf("N = %d, tao = %d, tw = %f\n\n", N, tao, tw);

  /* --- H(n) --- */
  double H[256]; // WARNING: increase this value for high frquencies

  // TODO: This section is unoptimized. It would be better to move these switch
  // statements to the function itself for a one line code.
  switch (wType) {
  case 0:
    switch (fType) {
    case 0:
      for (int n = 0; n < N; n++)
        H[n] = wnRectangular(n) * hdnLPF(wc1, n, tao);
      break;
    case 1:
      for (int n = 0; n < N; n++)
        H[n] = wnRectangular(n) * hdnHPF(wc1, n, tao);
      break;
    case 2:
      for (int n = 0; n < N; n++)
        H[n] = wnRectangular(n) * hdnBPF(wc1, wc2, n, tao);
      break;
    case 3:
      for (int n = 0; n < N; n++)
        H[n] = wnRectangular(n) * hdnBSF(wc1, wc2, n, tao);
      break;
    default:
      printf("Uncaught filter type\n");
      break;
    }
    break;
  case 1:
    switch (fType) {
    case 0:
      for (int n = 0; n < N; n++)
        H[n] = wnHanning(n, N) * hdnLPF(wc1, n, tao);
      break;
    case 1:
      for (int n = 0; n < N; n++)
        H[n] = wnHanning(n, N) * hdnHPF(wc1, n, tao);
      break;
    case 2:
      for (int n = 0; n < N; n++)
        H[n] = wnHanning(n, N) * hdnBPF(wc1, wc2, n, tao);
      break;
    case 3:
      for (int n = 0; n < N; n++)
        H[n] = wnHanning(n, N) * hdnBSF(wc1, wc2, n, tao);
      break;
    default:
      printf("Uncaught filter type\n");
      break;
    }
    break;
  case 2:
    switch (fType) {
    case 0:
      for (int n = 0; n < N; n++)
        H[n] = wnHamming(n, N) * hdnLPF(wc1, n, tao);
      break;
    case 1:
      for (int n = 0; n < N; n++)
        H[n] = wnHamming(n, N) * hdnHPF(wc1, n, tao);
      break;
    case 2:
      for (int n = 0; n < N; n++)
        H[n] = wnHamming(n, N) * hdnBPF(wc1, wc2, n, tao);
      break;
    case 3:
      for (int n = 0; n < N; n++)
        H[n] = wnHamming(n, N) * hdnBSF(wc1, wc2, n, tao);
      break;
    default:
      printf("Uncaught filter type\n");
      break;
    }
    break;

  default:
    printf("Uncaught window type\n");
    break;
  }

  for (int n = 0; n < N; n++) {
    printf("H(%d) = %0.10f\n", n, H[n]);
  }

  return 0;
}
