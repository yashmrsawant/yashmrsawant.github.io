---
layout: post
title: "The Fourier Transform: Mathematical Foundations, Inversion Proofs, and Neural Applications"
date: 2026-04-01
categories: [signal-processing, mathematics, neuroscience]
permalink: /posts/fourier-transform-theory-and-neural-applications.html
excerpt: "A comprehensive journey through the Fourier Transform: from physical intuition and the Continuous-Time formulation, to a rigorous proof of the Inversion Theorem via Gaussian regularization, and computational applications in neural time-frequency decoding."
---

From analyzing raw neural recordings to constructing biophysical brain models, **time-frequency analysis** [[1]](#ref-1) is one of the most indispensable tools in computational science and mathematics. Complex physiological dynamics—such as collective rhythmic oscillations in cortical circuits—often appear noisy and erratic in the raw time domain. Projecting these signals into the frequency domain decomposes complex waveforms into elementary sinusoidal components, revealing the underlying physiological generators.

In this unified exposition, we will build the Fourier Transform from first principles:
1. **The Continuous-Time Fourier Transform (CTFT)** — Intuition, forward/inverse equations, and physical variables.
2. **A Rigorous Proof of the Fourier Inversion Theorem** — Using parameterized Gaussian integrals, differentiation under the integral sign, and the Dirac delta limit.
3. **The Computational Bridge (DFT & FFT)** — How continuous theory translates into discrete algorithms.
4. **Applications to Neural Systems** — Decoding voltage dynamics, LFPs, and canonical oscillation frequency bands.

---

## 1. The Continuous-Time Fourier Transform (CTFT)

At its core, the Continuous-Time Fourier Transform acts as a mathematical prism. Just as an optical prism decomposes white light into its constituent spectral colors, the Fourier transform decomposes an arbitrary time-domain signal $x(t)$ into a continuous spectrum of complex exponentials.

### The Mathematical Definition

Under the linear frequency ($f$, in Hertz) convention:

$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} \, dt$$

The continuous-time signal is reconstructed via the **Continuous Inverse Fourier Transform (IFT)**:

$$x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} \, df$$

#### Angular Frequency Form ($\omega$)

When using radian angular frequency ($\omega = 2\pi f$, in $\text{rad/s}$), the symmetric unitary convention introduces a normalization factor $\frac{1}{\sqrt{2\pi}}$:

$$X(\omega) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt$$

$$x(t) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega$$

Alternatively, under the non-unitary convention:

$$X(\omega) = \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt, \qquad x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega$$

### Variables and Physical Units in Neuroscience

To ground these abstract variables in physical experiments, consider a continuous voltage recording (e.g., local field potential from an extracellular microelectrode):

* **$x(t)$**: The continuous time-domain biological signal (voltage in millivolts, $\text{mV}$).
* **$t$**: Continuous time measured in seconds ($\text{s}$).
* **$dt$**: The infinitesimal time increment ($\text{s}$).
* **$f$**: Frequency of oscillation measured in cycles per second or Hertz ($\text{Hz}$).
* **$X(f)$**: The complex Fourier coefficient at frequency $f$. Its magnitude $|X(f)|$ represents amplitude/energy density ($\text{mV}/\text{Hz}$), and its argument $\arg(X(f))$ encodes the phase angle.

---

## 2. Rigorous Proof of the Fourier Inversion Theorem

Why does applying the inverse transform to $X(f)$ faithfully reconstruct our original signal $x(t)$? Here, we evaluate the double integral using Gaussian convergence regularization.

<details open>
<summary>Click to view / collapse the complete step-by-step mathematical proof</summary>

### Step 1: Setting Up the Inversion Identity

Substitute the definition of $X(f)$ directly into the inverse formula:

$$x(t) = \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau} \, d\tau \right) e^{i 2\pi f t} \, df$$

Assuming $x(t)$ is absolutely integrable ($x \in L^1(\mathbb{R})$), we interchange the order of integration via Fubini's theorem:

$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} \, df \right) d\tau$$

Let the time difference variable be:

$$u = t - \tau$$

We must now evaluate the inner oscillatory integral:

$$\mathcal{K}(u) = \int_{-\infty}^{\infty} e^{i 2\pi f u} \, df$$

---

### Step 2: Euler's Expansion & Symmetry

Using Euler's identity $e^{i \theta} = \cos\theta + i \sin\theta$:

$$\int_{-\infty}^{\infty} e^{i 2\pi f u} \, df = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df + i \int_{-\infty}^{\infty} \sin(2\pi f u) \, df$$

Because $\sin(2\pi f u)$ is an odd function of $f$ over the symmetric interval $(-\infty, \infty)$, the imaginary term vanishes identically:

$$\int_{-\infty}^{\infty} \sin(2\pi f u) \, df = 0$$

The remaining cosine integral $\int_{-\infty}^{\infty} \cos(2\pi f u) \, df$ is oscillatory and does not converge in the Riemann sense. We introduce a convergence factor $e^{-a f^2}$ with regularizing parameter $a > 0$:

$$I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df$$

Note that as $a \to 0^+$, the damping factor approaches $1$.

---

### Step 3: Differentiating Under the Integral Sign

Differentiate $I_a(u)$ with respect to $u$ using Leibniz's rule:

$$\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} \, df$$

We apply integration by parts $\int U \, dV = UV - \int V \, dU$:

$$\text{Let } U = \sin(2\pi f u) \implies dU = 2\pi u \cos(2\pi f u) \, df$$

$$\text{Let } dV = -2\pi f e^{-a f^2} \, df \implies V = \frac{\pi}{a} e^{-a f^2}$$

Evaluating the boundary term:

$$\left[ U V \right]_{-\infty}^{\infty} = \left[ \frac{\pi}{a} \sin(2\pi f u) e^{-a f^2} \right]_{-\infty}^{\infty} = 0$$

Therefore:

$$\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df = -\frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df$$

Recognizing the original integral $I_a(u)$ on the right side:

$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)$$

---

### Step 4: Solving the Differential Equation

This is a first-order separable ordinary differential equation:

$$\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} \, du$$

Integrating both sides:

$$\ln I_a(u) = -\frac{\pi^2 u^2}{a} + C' \implies I_a(u) = C \exp\left( -\frac{\pi^2 u^2}{a} \right)$$

To determine the constant $C$, evaluate $I_a(u)$ at $u = 0$:

$$I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} \, df = \sqrt{\frac{\pi}{a}}$$

Substituting $C = \sqrt{\frac{\pi}{a}}$:

$$I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left( -\frac{\pi^2 u^2}{a} \right)$$

---

### Step 5: Limiting Behavior to the Dirac Delta

Rewrite $I_a(u)$ by defining $\sigma^2 = \frac{a}{2\pi^2}$:

$$I_a(u) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left( -\frac{u^2}{2\sigma^2} \right)$$

This is precisely the normalized Gaussian probability density function with total area equal to 1 for all $a > 0$:

$$\int_{-\infty}^{\infty} I_a(u) \, du = 1$$

As $a \to 0^+$, the variance $\sigma^2 \to 0$. The distribution narrows infinitely while maintaining unit area, which defines the Dirac delta distribution $\delta(u)$:

$$\lim_{a \to 0^+} I_a(u) = \delta(u) = \delta(t - \tau)$$

---

### Step 6: Reconstruction via the Sifting Property

Returning to the full double integral:

$$x(t) = \int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau$$

By the sifting property of the Dirac delta distribution:

$$\int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau = x(t)$$

$$\blacksquare \quad \text{The continuous inversion is mathematically verified.}$$

</details>

---

## 3. The Computational Bridge: Continuous to Discrete (DFT & FFT)

In real laboratory experiments, computers cannot record continuous signals or evaluate infinite integrals. We record signals at discrete sampling instances $t_n = n \Delta t$, sampled at rate $f_s = \frac{1}{\Delta t}$.

For a finite recording of $N$ discrete voltage measurements $x[n] = x(n \Delta t)$ for $n \in \{0, 1, \dots, N-1\}$, the continuous integral converts into the **Discrete Fourier Transform (DFT)**:

$$X[k] = \sum_{n=0}^{N-1} x[n] \exp\left( -i \frac{2\pi}{N} k n \right), \quad k = 0, 1, \dots, N-1$$

The sampled sequence is reconstructed via the **Inverse DFT**:

$$x[n] = \frac{1}{N} \sum_{k=0}^{N-1} X[k] \exp\left( i \frac{2\pi}{N} k n \right)$$

### The Fast Fourier Transform (FFT)

Direct computation of the matrix multiplication takes $\mathcal{O}(N^2)$ operations. In 1965, Cooley and Tukey formalized the **Fast Fourier Transform (FFT)**, which exploits symmetries in the complex roots of unity $W_N = e^{-i 2\pi / N}$:

$$W_N^{2k} = W_{N/2}^k$$

By recursively splitting the sum into even and odd indices (radix-2 decimation-in-time), the complexity reduces to $\mathcal{O}(N \log N)$. This logarithmic efficiency allows neuroscientists to process megabytes of 128-channel neural data in real time.

---

## 4. Neuroscience & Neural Applications

Applying spectral transforms to continuous neural recordings unlocks the frequency spectrum of brain activity:

```
Frequency Spectrum of Brain Dynamics:
┌─────────────────┬─────────────┬────────────────────────────────────────────────────────┐
│ Band Name       │ Frequency   │ Physiological Role & Behavioral State                  │
├─────────────────┼─────────────┼────────────────────────────────────────────────────────┤
│ Delta (δ)       │ 0.5 – 4 Hz  │ Deep slow-wave sleep, broad cortical synchronization   │
│ Theta (θ)       │ 4 – 8 Hz    │ Hippocampal spatial navigation, memory encoding        │
│ Alpha (α)       │ 8 – 12 Hz   │ Posterior cortical idling, visual sensory gating       │
│ Beta (β)        │ 12 – 30 Hz  │ Motor cortex active planning, sensorimotor stability   │
│ Gamma (γ)       │ 30 – 100+ Hz│ Local interneuron circuits, binding, active processing │
└─────────────────┴─────────────┴────────────────────────────────────────────────────────┘
```

### Local Field Potentials (LFPs) & Phase Synchronization

When microelectrodes measure extracellular fields, the low-frequency component ($<300\text{ Hz}$) captures synaptic currents synchronized across thousands of neurons. 

Through the Fourier transform, neuroscientists extract:
1. **Power Spectral Density (PSD)**: Quantifying the energy distribution across oscillatory bands to measure cognitive engagement.
2. **Phase-Amplitude Coupling (PAC)**: How the phase of a low-frequency rhythm (e.g., Theta at $6\text{ Hz}$) modulates the amplitude envelope of high-frequency bursts (e.g., Gamma at $80\text{ Hz}$), a foundational mechanism for working memory and neural coordination.

---

## Conclusion & Future Directions

The Fourier Transform is a bridge connecting abstract functional analysis with empirical biological discovery. Starting from simple sinusoidal decomposition, Gaussian convergence theorems guarantee exact mathematical inversion, while efficient FFT algorithms allow modern neuroscience to decode the computational principles of the brain.

In future articles, we will explore **wavelet transforms** and **non-stationary dynamical systems** that extend time-frequency analysis beyond linear assumptions.

---

## References

<div id="ref-1"></div>

**[1]** Popescu, T. (1997). Time-frequency analysis, by L. Cohen, Prentice Hall Signal Processing Series, Prentice Hall, Englewood Cliffs, New Jersey, 1995 - Book review. *Control Engineering Practice, 5*, 292–294. [https://doi.org/10.1016/S0967-0661(97)90028-9](https://doi.org/10.1016/S0967-0661(97)90028-9)

**[2]** Cohen, L. (1995). *Time-Frequency Analysis*. Prentice Hall Signal Processing Series.

**[3]** Buzsáki, G. (2006). *Rhythms of the Brain*. Oxford University Press.
