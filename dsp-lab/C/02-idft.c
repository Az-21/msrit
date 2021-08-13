#include <math.h>
#include <stdio.h>

// Inverse Discrete Fourier Transform (IDFT)
int main() {
  // Input signal
  const double Xk_re[] = {10, -2, -2, -2};
  const double Xk_im[] = {0, 2, 0, -2};

  // Output signal init
  double xn_re[64];
  double xn_im[64];

  // Consts
  const int N = sizeof(Xk_re) / sizeof(Xk_re[0]);
  const double pi = 3.14159265359;

  // IDFT using for loop
  for (int k = 0; k < N; k++) {
    // Init
    xn_re[k] = 0;
    xn_im[k] = 0;

    // Sigma IDFT
    for (int n = 0; n < N; n++) {
      double theta = 2 * pi * n * k / N;
      xn_re[k] += Xk_re[n] * cos(theta) - Xk_im[n] * sin(theta);
      xn_im[k] += Xk_re[n] * sin(theta) + Xk_im[n] * cos(theta);
    }

    xn_re[k] /= N;
    xn_im[k] /= N;

    if (xn_im[k] < 0) {
      printf("%0.10f - i %0.10f\n", xn_re[k], -xn_im[k]);
    } else {
      printf("%0.10f + i %0.10f\n", xn_re[k], xn_im[k]);
    }
  }

  return 0;
}
