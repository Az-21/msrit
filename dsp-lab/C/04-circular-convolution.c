#include <math.h>
#include <stdio.h>

// Circular convolution using sliding method
int main() {
  // Input signals
  const double inX[] = {1, 2, 3, 4};
  const double inH[] = {1, -1, 1};

  // Zero padding
  const int xLen = sizeof(inX) / sizeof(inX[0]);
  const int hLen = sizeof(inH) / sizeof(inH[0]);
  int N;
  printf("Enter period of signal: ");
  scanf_s("%d", &N);

  int minN = xLen + hLen - 1;
  if (minN > N)
    N = minN;

  double x[64], h[64], y[64]; // Init new arrays for zero padding

  printf("y(n) = ");
  for (int i = 0; i < N; i++) {
    if (i < xLen)
      x[i] = inX[i];
    else
      x[i] = 0;

    if (i < hLen)
      h[i] = inH[i];
    else
      h[i] = 0;
  }

  // Slide multiplication
  for (int i = 0; i < N; i++) {
    double sigma = 0; // sum of each overlap slide
    for (int j = 0; j <= i; j++)
      sigma += x[j] * h[i - j];
    printf("%0.3f ", sigma);
  }

  return 0;
}