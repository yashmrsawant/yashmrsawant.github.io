---
layout: post
title: "The Fourier Transform: Theory, The Crucial Identity, and Inversion Proofs"
date: 2026-04-01
categories: [signal-processing, mathematics]
permalink: /posts/fourier-transform-theory-and-neural-applications.html
excerpt: "A rigorous mathematical journey through the Fourier Transform: from continuous-time definitions and physical variables, to the crucial distribution identity for periodic complex exponentials, culminating in the complete Gaussian regularization proof of the Fourier Inversion Theorem."
---

From analyzing physical wave phenomena to modeling dynamical systems, the **Fourier Transform** is a foundational cornerstone of mathematical analysis and applied physics. It provides an exact, invertible mapping between the continuous time domain and the continuous frequency spectrum.

In this exposition, we build the core mathematical framework from first principles:
1. **The Continuous-Time Fourier Transform (CTFT)** — Definitions, symmetrical forms, and physical intuition.
2. **The Crucial Identity** — The distributional Poisson summation identity for infinite trains of harmonic exponentials.
3. **Rigorous Proof of the Fourier Inversion Theorem** — Step-by-step evaluation using parameterized Gaussian convergence factors, differentiation under the integral sign, and the Dirac delta limit.

---

## 1. The Continuous-Time Fourier Transform (CTFT)

At its core, the Continuous-Time Fourier Transform decomposes an arbitrary continuous-time signal $x(t)$ into a continuous spectrum of complex exponential basis functions.

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

### Variables and Physical Units

To ground these abstract mathematical variables in physical experiments (such as physiological voltage recordings):

* **$x(t)$**: The continuous time-domain signal (e.g., voltage in millivolts, $\text{mV}$).
* **$t$**: Continuous time measured in seconds ($\text{s}$).
* **$dt$**: Infinitesimal time integration step ($\text{s}$).
* **$f$**: Linear oscillation frequency in cycles per second ($\text{Hz}$).
* **$\omega$**: Radian angular frequency ($\text{rad/s}$), related to linear frequency by $\omega = 2\pi f$.
* **$X(f)$**: The complex Fourier coefficient at frequency $f$. Its magnitude $\vert X(f) \vert$ represents the spectral amplitude/density (in $\text{mV}/\text{Hz}$), and its argument $\arg(X(f))$ encodes the phase angle.

---

## 2. The Crucial Identity

Before establishing the inversion theorem, we examine an essential identity that governs periodic harmonic sums in the sense of generalized functions (tempered distributions, $\mathcal{S}'(\mathbb{R})$):

$$
\boxed{
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

### Understanding the Identity

Let's understand why this identity holds and what it reveals geometrically:

#### 1. Periodicity in the Frequency Domain
The left-hand side is strictly periodic in $\omega$ with fundamental period $\Omega = \frac{2\pi}{T}$. To see this directly, shift $\omega$ by $\frac{2\pi}{T}$:

$$
e^{-inT\left(\omega + \frac{2\pi}{T}\right)}
= e^{-inT\omega} \, e^{-i 2\pi n}
= e^{-inT\omega}
$$

Since $n$ is an integer, $e^{-i 2\pi n} = \cos(2\pi n) - i\sin(2\pi n) = 1$ for all $n \in \mathbb{Z}$. 

Consequently, the infinite sum repeats identically every $\frac{2\pi}{T}$:

$$
\sum_{n=-\infty}^{\infty} e^{-inT\left(\omega + \frac{2\pi}{T}\right)} = \sum_{n=-\infty}^{\infty} e^{-inT\omega}
$$

#### 2. Constructive vs. Destructive Interference
* **At multiples of the fundamental frequency ($\omega = \frac{2\pi k}{T}$):**  
  Every term in the series evaluates to $e^{-inT(2\pi k/T)} = e^{-i 2\pi n k} = 1$. The infinitely many terms sum in perfect phase, yielding a singular divergence (a Dirac impulse $\delta$) scaled by the density factor $\frac{2\pi}{T}$.
* **Between the harmonics ($\omega \neq \frac{2\pi k}{T}$):**  
  The complex phasors $e^{-inT\omega}$ rotate uniformly around the unit circle. When integrated against any smooth test function $\phi \in \mathcal{S}(\mathbb{R})$, the oscillatory terms destructively interfere and vanish identically.

This identity is the distributional foundation connecting discrete sampling in time to periodic replication in frequency (the Poisson Summation Formula).

---

## 3. Rigorous Proof of the Fourier Inversion Theorem

Why does applying the continuous inverse transform to $X(f)$ faithfully reconstruct the original signal $x(t)$? 

We now evaluate the double integral using Gaussian convergence regularization.

<details open>
<summary>Click to view / collapse the complete step-by-step mathematical proof</summary>

### Step 1: Setting Up the Inversion Identity

Substitute the definition of the forward transform $X(f)$ directly into the inverse formula:

$$x(t) = \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau} \, d\tau \right) e^{i 2\pi f t} \, df$$

Assuming $x \in L^1(\mathbb{R})$, we interchange the order of integration via Fubini's theorem:

$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} \, df \right) d\tau$$

Let the time displacement variable be:

$$u = t - \tau$$

We must now evaluate the inner oscillatory integral:

$$\mathcal{K}(u) = \int_{-\infty}^{\infty} e^{i 2\pi f u} \, df$$

---

### Step 2: Euler's Expansion & Symmetry

Using Euler's formula $e^{i \theta} = \cos\theta + i \sin\theta$:

$$\int_{-\infty}^{\infty} e^{i 2\pi f u} \, df = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df + i \int_{-\infty}^{\infty} \sin(2\pi f u) \, df$$

Because $\sin(2\pi f u)$ is an odd function of $f$ over the symmetric interval $(-\infty, \infty)$, the imaginary term vanishes identically:

$$\int_{-\infty}^{\infty} \sin(2\pi f u) \, df = 0$$

The remaining cosine integral $\int_{-\infty}^{\infty} \cos(2\pi f u) \, df$ is oscillatory and does not converge in the standard Riemann sense. We introduce a Gaussian convergence factor $e^{-a f^2}$ with parameter $a > 0$:

$$I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df$$

As $a \to 0^+$, the damping factor approaches $1$.

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

Rewrite $I_a(u)$ by setting $\sigma^2 = \frac{a}{2\pi^2}$:

$$I_a(u) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left( -\frac{u^2}{2\sigma^2} \right)$$

This is precisely the normalized Gaussian probability density function with total area equal to 1 for all $a > 0$:

$$\int_{-\infty}^{\infty} I_a(u) \, du = 1$$

As $a \to 0^+$, the variance $\sigma^2 \to 0$. The distribution narrows infinitely while maintaining unit area, which defines the Dirac delta distribution $\delta(u)$:

$$\lim_{a \to 0^+} I_a(u) = \delta(u) = \delta(t - \tau)$$

---

### Step 6: Reconstruction via the Sifting Property

Substituting this result back into the full double integral:

$$x(t) = \int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau$$

By the sifting property of the Dirac delta distribution:

$$\int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau = x(t)$$

$$\blacksquare \quad \text{The continuous inversion is mathematically verified.}$$

</details>
