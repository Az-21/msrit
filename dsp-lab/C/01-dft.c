#include <math.h>
#include <stdio.h>

// Discrete Fourier Transform (DFT)
int main() {
  // Input signal
  const double xn_re[] = {1, 2, 3, 4};
  const double xn_im[] = {0, 0, 0, 0};

  // Output signal init
  double Xk_re[64];
  double Xk_im[64];

  // Consts
  const int N = sizeof(xn_re) / sizeof(xn_re[0]);
  const double pi = 3.14159265359;

  // DFT using for loop
  for (int n = 0; n < N; n++) {
    // Init
    Xk_re[n] = 0;
    Xk_im[n] = 0;

    // Sigma DFT
    for (int k = 0; k < N; k++) {
      double theta = 2 * pi * n * k / N;
      Xk_re[n] += xn_re[k] * cos(theta) + xn_im[k] * sin(theta);
      Xk_im[n] += -xn_re[k] * sin(theta) + xn_im[k] * cos(theta);
    }

    if (Xk_im[n] < 0)
      printf("%0.10f - i %0.10f\n", Xk_re[n], -Xk_im[n]);
    else
      printf("%0.10f + i %0.10f\n", Xk_re[n], Xk_im[n]);
  }

  return 0;
}
