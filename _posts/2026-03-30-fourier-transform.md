---
layout: default
title: "The Fourier Transform: From Theory to Neural Applications"
date: 2026-03-30
categories: [Signal Processing, Time-Series Analysis]
---

From analyzing raw neural signals to building computational models, time-frequency analysis[[1]](#ref-1) is an essential tool for decoding the complex inner workings of the brain.

In this post, we will cover:
1. **Introduction to the Fourier Transform:** The core intuition behind decomposing real-world signals into simple waves.
2. **From Math to Code:** Bridging the gap between the analytical Continuous-Time Fourier Transform (CTFT) and its computational implementation, the Fast Fourier Transform (FFT).
3. **Scientific Applications:** How this mathematical breakthrough powers modern tools like Magnetic Resonance Imaging (MRI) and neural time-series analysis.

---

## 1. The Continuous-Time Fourier Transform (CTFT)

At its core, the CTFT acts as a mathematical prism. Just as a glass prism splits white light into its constituent colors, the Fourier Transform translates a continuous-time signal into a continuous-frequency spectrum, revealing the underlying frequencies that make up the data.

### The Mathematical Definition

The operation is defined by the following integral, which compares our signal against complex sinusoids of every possible frequency:

$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$

To return to the time domain, we use the **Inverse Fourier Transform**:

$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} df$$

### Variables and Physical Intuition

To ground this in reality, let's look at these variables through the lens of neuroscience, assuming we are applying the CTFT to a continuous-time neural voltage signal:

* **$$x(t)$$**: The continuous-time signal itself (e.g., a neural recording), typically measured in millivolts (mV).
* **$$t$$**: The time at which the signal is measured, with units in seconds (s).
* **$$dt$$**: The infinitesimal integration step over time, measured in seconds (s).
* **$$f$$**: The specific frequency variable being analyzed, measured in Hertz (Hz).
* **$$X(f)$$**: The resulting output. This gives us the complex amplitude and phase of the signal at frequency $$f$$.

---

## References

<div id="ref-1"></div>
**[1]** Popescu, T. (1997). Time-frequency analysis, by L. Cohen, Prentice Hall Signal Processing Series, Prentice Hall, Englewood Cliffs, New Jersey, 1995 - Book review. *Control Engineering Practice, 5*, 292–294. [https://doi.org/10.1016/S0967-0661(97)90028-9](https://doi.org/10.1016/S0967-0661(97)90028-9)


