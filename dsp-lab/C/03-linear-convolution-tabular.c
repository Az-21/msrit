#include <math.h>
#include <stdio.h>

// Linear convolution using tabular method
int main() {
  const double x[] = {2, 1, 0, 8};
  const double h[] = {1, 9, 9, 5};

  const int N = sizeof(x) / sizeof(x[0]);
  const int M = sizeof(h) / sizeof(h[0]);

  double yMatrix[32][32];

  for (int i = 0; i < M; i++) {
    int cursor = 0; // const row, variable column cursor

    // Left zero padding
    for (int k = 0; k < i; k++) {
      yMatrix[i][cursor] = 0;
      cursor++;
    }

    // Sequence multiplication
    for (int j = 0; j < N; j++) {
      yMatrix[i][cursor] = x[j] * h[i];
      cursor++;
    }
    // Right zero padding
    for (int k = 0; k < M - i; k++) {
      yMatrix[i][cursor] = 0;
      cursor++;
    }
  }

  // Init mem for storing result
  double y[32];
  for (int i = 0; i < N + M - 1; i++) {
    y[i] = 0;
  }

  // Adding columns for final result
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N + M - 1; j++) {
      printf("%0.0f ", yMatrix[i][j]);
      y[j] += yMatrix[i][j];
    }
    printf("\n");
  }

  printf("\n");
  for (int i = 0; i < N + M - 1; i++) {
    printf("%0.0f ", y[i]);
  }

  return 0;
}