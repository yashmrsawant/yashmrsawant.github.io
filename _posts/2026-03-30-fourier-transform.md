---
layout: default
title: "The Fourier Transform: From Theory to Neural Applications"
date: 2026-03-30
categories: [Signal Processing, Time-Series Analysis]
---

Welcome to this deep dive into the Fourier Transform. Whether you are analyzing electrical signals from the brain or building computational models, understanding how to transition between time and frequency is an indispensable skill.

In this post, we will cover:
1. **Introduction to the Fourier Transform:** The core intuition behind decomposing complex signals into simple waves.
2. **From Math to Code:** Bridging the gap between the analytical Continuous-Time Fourier Transform (CTFT) and its computational implementation, the Fast Fourier Transform (FFT).
3. **Scientific Applications:** How this mathematical breakthrough powers modern tools like Magnetic Resonance Imaging (MRI) and neural time-series analysis.

---

## 1. The Continuous-Time Fourier Transform (CTFT)

At its core, the CTFT acts as a mathematical prism. Just as a glass prism splits white light into its constituent colors, the Fourier Transform translates a continuous-time signal into a continuous-frequency spectrum, revealing the underlying frequencies that make up the data.

### The Mathematical Definition

The operation is defined by the following integral, which compares our signal against complex sinusoids of every possible frequency:

$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$

### Variables and Physical Intuition

To ground this in reality, let's look at these variables through the lens of neuroscience, assuming we are applying the CTFT to a continuous-time neural voltage signal:

* **$x(t)$**: The continuous-time signal itself (e.g., a neural recording), typically measured in millivolts (mV).
* **$t$**: The time at which the signal is measured, with units in seconds (s).
* **$dt$**: The infinitesimal integration step over time, measured in seconds (s).
* **$f$**: The specific frequency variable being analyzed, measured in Hertz (Hz).
* **$X(f)$**: The resulting output. This gives us the complex amplitude and phase of the signal at frequency $f$.