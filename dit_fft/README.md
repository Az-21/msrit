# Decimation In Time Fast Fourier Transform (DITFFT)

- Towards **Digital Signals Processing** (DSP) CIE Component
- Semester VI

### Interactive App
[WebApp](https://vercel.com/az-21/dft-calculator/7brq8A3nBB5cbZTUQFaJd6LDMBP6)

[Android App](https://play.google.com/store/apps/details?id=com.flutterDevAz21.dft&hl=en&gl=US)

### Files

```dart
./dit_fft/fft.dart                // Static DITFFT
```

### Built Using

- Dart
- Radix2 algorithm

### Complex numbers library

Complex number library provided by [rwl](https://github.com/rwl) on [pub.dev](https://pub.dev/packages/complex) under [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

This package gives the same level of complex math computation functionality as `cmath` in Python3.

### Sample I/O

```dart
x(0) =  0.500 + i(0.000)   ⸻⸻>   X(0) =  2.000 + i(0.000)
x(1) =  0.500 + i(0.000)   ⸻⸻>   X(1) =  0.500 - i(1.207)
x(2) =  0.500 + i(0.000)   ⸻⸻>   X(2) =  0.000 + i(0.000)
x(3) =  0.500 + i(0.000)   ⸻⸻>   X(3) =  0.500 - i(0.207)
x(4) =  0.000 + i(0.000)   ⸻⸻>   X(4) =  0.000 + i(0.000)
x(5) =  0.000 + i(0.000)   ⸻⸻>   X(5) =  0.500 + i(0.207)
x(6) =  0.000 + i(0.000)   ⸻⸻>   X(6) =  0.000 + i(0.000)
x(7) =  0.000 + i(0.000)   ⸻⸻>   X(7) =  0.500 + i(1.207)
```
