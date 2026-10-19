---
layout: post
title: "Theory for Analyzing Brain Signals: Fourier Transform"
date: 2026-04-01
categories: [signal-processing, mathematics]
permalink: /posts/fourier-transform-theory-and-neural-applications.html
excerpt: "A rigorous mathematical journey through the Fourier Transform: from continuous-time definitions and physical variables, to the complete Gaussian regularization proof of the Fourier Inversion Theorem, and finally impulse-train sampling and the distributional proof of the Discrete-Time Fourier Transform (DTFT)."
outline:
  - title: "The Continuous-Time Fourier Transform (CTFT)"
    url: "#1-the-continuous-time-fourier-transform-ctft"
  - title: "Discrete-Time Fourier Transform (DTFT)"
    url: "#2-discrete-time-fourier-transform-dtft"
---

From analyzing physical wave phenomena to modeling dynamical systems and neural oscillations, the **Fourier Transform** is a foundational cornerstone of mathematical analysis and applied physics. It provides an exact, invertible mapping between the time domain and the frequency spectrum.

In this exposition, we build the core mathematical framework from first principles:
1. **The Continuous-Time Fourier Transform (CTFT)** — Mathematical definitions, physical units, and the complete Gaussian regularization proof of the Fourier Inversion Theorem.
2. **The Discrete-Time Fourier Transform (DTFT)** — How we transition from continuous signals to discrete samples via a Dirac impulse train $s(t)$, culminating in the distributional proof of spectral replication.

---

## 1. The Continuous-Time Fourier Transform (CTFT)
<a id="1-the-continuous-time-fourier-transform-ctft"></a>

At its core, the Continuous-Time Fourier Transform decomposes an arbitrary continuous-time signal $x(t)$ into a continuous spectrum of complex exponential basis functions.

### The Mathematical Definition

Under the linear frequency ($f$, in Hertz) convention, the forward transform is defined as:

$$
X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} \, dt
$$

The continuous-time signal is reconstructed via the **Continuous Inverse Fourier Transform (IFT)**:

$$
x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} \, df
$$

#### Angular Frequency Form ($\omega$)

When using radian angular frequency ($\omega = 2\pi f$, in $\text{rad/s}$), substituting $df = \frac{d\omega}{2\pi}$ introduces a factor of $\frac{1}{2\pi}$. Under the **symmetric unitary convention**, this normalization factor is split equally between the forward and inverse transforms as $\frac{1}{\sqrt{2\pi}}$:

$$
X(\omega) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt
$$

$$
x(t) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega
$$

Alternatively, under the **non-unitary convention** (standard in signal processing), the forward transform is unscaled while the inverse transform carries the $\frac{1}{2\pi}$ factor:

$$
X(\omega) = \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt, \qquad x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega
$$

### Variables and Physical Units

To ground these abstract mathematical variables in physical experiments (such as physiological voltage recordings in neuroscience):

- **$x(t)$**: The continuous time-domain signal (e.g., extracellular or membrane voltage in millivolts, $\text{mV}$).
- **$t$**: Continuous time measured in seconds ($\text{s}$).
- **$dt$**: Infinitesimal time integration step ($\text{s}$).
- **$f$**: Linear oscillation frequency in cycles per second ($\text{Hz} = \text{s}^{-1}$).
- **$\omega$**: Radian angular frequency ($\text{rad/s}$), related to linear frequency by $\omega = 2\pi f$.
- **$X(f)$**: The complex Fourier coefficient at frequency $f$. Its magnitude $\vert X(f) \vert$ represents the spectral amplitude density (in $\text{mV}/\text{Hz}$ or $\text{mV}\cdot\text{s}$), and its argument $\arg(X(f))$ encodes the phase angle in radians.

---

### Proof of the Fourier Inversion Theorem

Why does applying the continuous inverse transform to $X(f)$ faithfully reconstruct the original signal $x(t)$? 

Because the inner oscillatory integral does not converge in the classical Riemann sense, we evaluate the double integral using **Gaussian convergence regularization**.

<details open markdown="1">
<summary><strong>Click to view / collapse the complete step-by-step mathematical proof</strong></summary>

<br>

**Step 1: Setting Up the Inversion Identity**

Substitute the definition of the forward transform $X(f)$ directly into the inverse formula:

$$
x(t) = \int_{-\infty}^{\infty}
\left(
\int_{-\infty}^{\infty}
x(\tau)e^{-i2\pi f\tau}\,d\tau
\right)e^{i2\pi ft}\,df
$$

Assume that $x:\mathbb{R}\to\mathbb{C}$ is an absolutely integrable function, i.e.,

$$
\int_{-\infty}^{\infty}|x(t)|\,dt < \infty.
$$

In other words, $x\in L^1(\mathbb{R})$. Interchanging the order of integration formally using Fubini's theorem gives:

$$
x(t) = \int_{-\infty}^{\infty}x(\tau)
\left(
\int_{-\infty}^{\infty}
e^{i2\pi f(t-\tau)}\,df
\right)d\tau.
$$

Let the time displacement variable be:

$$
u = t - \tau.
$$

We must now evaluate the inner oscillatory integral:

$$
\mathcal{K}(u) = \int_{-\infty}^{\infty}e^{i2\pi fu}\,df.
$$

The kernel $\mathcal{K}(u)$ is interpreted in the distributional sense as the Dirac delta $\delta(u)$.

<br>

**Step 2: Proof of $\mathcal{K}(u) = \delta(u)$**

Using Euler's formula $e^{i \theta} = \cos\theta + i \sin\theta$:

$$
\int_{-\infty}^{\infty} e^{i 2\pi f u} \, df = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df + i \int_{-\infty}^{\infty} \sin(2\pi f u) \, df
$$

Because $\sin(2\pi f u)$ is an odd function of $f$ over the symmetric interval $(-\infty, \infty)$, the imaginary term vanishes identically:

$$
\int_{-\infty}^{\infty} \sin(2\pi f u) \, df = 0
$$

The remaining cosine integral $\int_{-\infty}^{\infty} \cos(2\pi f u) \, df$ is oscillatory and does not converge in the standard Riemann sense. We introduce a Gaussian convergence factor $e^{-a f^2}$ with parameter $a > 0$:

$$
I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df
$$

As $a \to 0^+$, the damping factor approaches $1$.

<br>

**Step 3: Differentiating Under the Integral Sign**

Differentiate $I_a(u)$ with respect to $u$ using Leibniz's rule:

$$
\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} \, df
$$

We apply integration by parts $\int U \, dV = UV - \int V \, dU$:

$$
\text{Let } U = \sin(2\pi f u) \implies dU = 2\pi u \cos(2\pi f u) \, df
$$

$$
\text{Let } dV = -2\pi f e^{-a f^2} \, df \implies V = \frac{\pi}{a} e^{-a f^2}
$$

Evaluating the boundary term:

$$
\left[ U V \right]_{-\infty}^{\infty} = \left[ \frac{\pi}{a} \sin(2\pi f u) e^{-a f^2} \right]_{-\infty}^{\infty} = 0
$$

Therefore:

$$
\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df = -\frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df
$$

Recognizing the original integral $I_a(u)$ on the right side:

$$
\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)
$$

<br>

**Step 4: Solving the Differential Equation**

This is a first-order separable ordinary differential equation:

$$
\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} \, du
$$

Integrating both sides:

$$
\ln I_a(u) = -\frac{\pi^2 u^2}{a} + C' \implies I_a(u) = C \exp\left( -\frac{\pi^2 u^2}{a} \right)
$$

To determine the constant $C$, evaluate $I_a(u)$ at $u = 0$:

$$
I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} \, df = \sqrt{\frac{\pi}{a}}
$$

Substituting $C = \sqrt{\frac{\pi}{a}}$:

$$
I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left( -\frac{\pi^2 u^2}{a} \right)
$$

<br>

**Step 5: Limiting Behavior to the Dirac Delta**

Rewrite $I_a(u)$ by setting $\sigma^2 = \frac{a}{2\pi^2}$:

$$
I_a(u) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left( -\frac{u^2}{2\sigma^2} \right)
$$

This is precisely the normalized Gaussian probability density function with total area equal to $1$ for all $a > 0$:

$$
\int_{-\infty}^{\infty} I_a(u) \, du = 1
$$

As $a \to 0^+$, the variance $\sigma^2 \to 0$. The distribution narrows infinitely while maintaining unit area, which defines the Dirac delta distribution $\delta(u)$:

$$
\lim_{a \to 0^+} I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df = \mathcal{K}(u) = \delta(u) = \delta(t - \tau)
$$

<br>

**Step 6: Reconstruction via the Sifting Property**

Substituting this result back into the full double integral:

$$
x(t) = \int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau
$$

By the sifting property of the Dirac delta distribution:

$$
\int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau = x(t) \qquad \blacksquare
$$

</details>

---

## 2. Discrete-Time Fourier Transform (DTFT)
<a id="2-discrete-time-fourier-transform-dtft"></a>

In empirical recordings (such as digital electrophysiology), we cannot record a continuous signal $x(t)$ at every real instant $t \in \mathbb{R}$. Instead, we sample the continuous signal at uniform time intervals of duration $T$ (with sampling frequency $f_s = \frac{1}{T}$ in $\text{Hz}$, or angular sampling frequency $\Omega = \frac{2\pi}{T}$ in $\text{rad/s}$).

### 2.1 Ideal Impulse-Train Sampling

To bridge continuous-time analysis and discrete-time sequences mathematically, we model ideal sampling using a periodic **Dirac delta train** (or **Dirac comb**) $s(t)$ of period $T$:

$$
s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT)
$$

Multiplying our continuous-time signal $x(t)$ by the sampling train $s(t)$ produces the **sampled continuous-time signal** $x_s(t)$:

$$
x_s(t) = x(t) \cdot s(t) = x(t) \sum_{n=-\infty}^{\infty} \delta(t - nT)
$$

Because each impulse $\delta(t - nT)$ is supported solely at the discrete sampling instant $t = nT$, we invoke the scaling property $x(t)\delta(t - nT) = x(nT)\delta(t - nT)$ to obtain:

$$
x_s(t) = \sum_{n=-\infty}^{\infty} x(nT) \, \delta(t - nT)
$$

### 2.2 Deriving the DTFT from the Sampled Signal

We now compute the Continuous-Time Fourier Transform (in non-unitary angular frequency $\omega$) of the impulse-sampled signal $x_s(t)$:

$$
X_s(\omega) = \int_{-\infty}^{\infty} x_s(t) e^{-i\omega t} \, dt = \int_{-\infty}^{\infty} \left( \sum_{n=-\infty}^{\infty} x(nT) \, \delta(t - nT) \right) e^{-i\omega t} \, dt
$$

Interchanging the summation and integration yields:

$$
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) \int_{-\infty}^{\infty} \delta(t - nT) e^{-i\omega t} \, dt
$$

By the sifting property of the Dirac delta ($\int_{-\infty}^{\infty} \delta(t - nT) e^{-i\omega t} \, dt = e^{-inT\omega}$), this reduces directly to the **Discrete-Time Fourier Transform (DTFT)**:

$$
\boxed{
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) e^{-inT\omega}
}
$$

How does the spectrum of the sampled signal $X_s(\omega)$ relate to the original continuous-time spectrum $X(\omega)$? 

Substitute the inverse CTFT evaluated at $t = nT$, namely $x(nT) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) e^{inT\theta} \, d\theta$, into the DTFT above:

$$
\begin{aligned}
X_s(\omega) 
&= \sum_{n=-\infty}^{\infty} \left( \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) e^{inT\theta} \, d\theta \right) e^{-inT\omega} \\
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \left( \sum_{n=-\infty}^{\infty} e^{-inT(\omega - \theta)} \right) d\theta
\end{aligned}
$$

Evaluating this integral—and proving how discrete sampling alters the frequency spectrum—hinges entirely on the distributional identity for the infinite harmonic sum $\sum_{n=-\infty}^{\infty} e^{-inT\omega}$.

---

### 2.3 The Crucial Distributional Identity
<a id="2-the-crucial-identity"></a>

We examine here the essential identity that governs periodic harmonic sums in the sense of generalized functions (tempered distributions, $\mathcal{S}'(\mathbb{R})$):

$$
\boxed{
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

*(Note: This is precisely the Continuous-Time Fourier Transform of the Dirac delta train $s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT)$).*

#### Understanding the Identity

Let us understand why this identity holds and what it reveals geometrically.

##### 1. Periodicity in the Frequency Domain

The left-hand side is periodic in $\omega$ with period $\Omega = \frac{2\pi}{T}$. To see this directly, shift $\omega$ by $\frac{2\pi}{T}$:

$$
\begin{aligned}
e^{-inT\left(\omega + \frac{2\pi}{T}\right)}
&= e^{-inT\omega} e^{-i 2\pi n} \\
&= e^{-inT\omega}.
\end{aligned}
$$

Since $n$ is an integer, $e^{-i 2\pi n} = \cos(2\pi n) - i\sin(2\pi n) = 1$ for all $n \in \mathbb{Z}$.

Consequently, the infinite sum is periodic in the distributional sense, with period $\frac{2\pi}{T}$:

$$
\sum_{n=-\infty}^{\infty} e^{-inT\left(\omega + \frac{2\pi}{T}\right)} = \sum_{n=-\infty}^{\infty} e^{-inT\omega}.
$$

##### 2. Constructive vs. Destructive Interference

- **At multiples of the fundamental frequency $\left(\omega = \frac{2\pi k}{T}\right)$:**

  Every term in the series evaluates to:

  $$
  e^{-inT(2\pi k/T)} = e^{-i 2\pi n k} = 1.
  $$

  The terms therefore add in perfect phase. For a finite sum, the peak height grows linearly with the number of terms. In the distributional limit, this concentration produces Dirac impulses with weight $\frac{2\pi}{T}$.

- **Between the harmonics $\left(\omega \neq \frac{2\pi k}{T}\right)$:**

  The complex phasors $e^{-inT\omega}$ rotate around the unit circle. Their finite sums remain bounded at any fixed frequency away from the harmonics. In the distributional limit, the oscillatory contributions cancel when integrated against a smooth, rapidly decreasing test function $\phi \in \mathcal{S}(\mathbb{R})$, leaving the Dirac impulse train.

Importantly, this cancellation is understood in the distributional sense; the infinite series does not converge pointwise to zero between the harmonics.

---

##### 3. The Finite-Sum Dirichlet Kernel

To understand how the impulses emerge, truncate the infinite series to $2N+1$ terms:

$$
\begin{aligned}
S_N(\omega)
&= \sum_{n=-N}^{N} e^{-inT\omega} \\
&= 1 + 2\sum_{n=1}^{N} \cos(nT\omega) \\
&= \frac{\sin\left(\left(N + \frac{1}{2}\right) T\omega\right)}{\sin\left(\frac{1}{2} T\omega\right)}.
\end{aligned}
$$

This is a Dirichlet kernel evaluated at $T\omega$.

As $N \to \infty$, the finite sums exhibit the following behaviour:

- **Peak height:** At $\omega_k = \frac{2\pi k}{T}$, the limiting value of the finite sum is obtained by continuity:

  $$
  S_N(\omega_k) = 2N + 1.
  $$

- **Main-lobe width:** The first zeros around $\omega = 0$ occur at:

  $$
  \omega = \pm\frac{2\pi}{(2N+1)T}.
  $$

  Thus, the width between the first zeros is:

  $$
  \Delta\omega = \frac{4\pi}{(2N+1)T}.
  $$

- **Distributional limit:** The peaks become increasingly narrow and tall. However, the Dirichlet kernel also has oscillatory side lobes, so its total signed area, rather than the area of its central lobe alone, is the relevant quantity for determining the impulse weight.

##### 4. Why the Prefactor Is $\frac{2\pi}{T}$

The exact prefactor can be determined by integrating the finite sum over one fundamental period, $\left[-\frac{\pi}{T}, \frac{\pi}{T}\right]$:

$$
\begin{aligned}
\int_{-\pi/T}^{\pi/T} S_N(\omega) \, d\omega
&= \sum_{n=-N}^{N} \int_{-\pi/T}^{\pi/T} e^{-inT\omega} \, d\omega \\
&= \frac{2\pi}{T}.
\end{aligned}
$$

For every nonzero integer $n$, the corresponding exponential integrates to zero over this interval. Only the constant term ($n=0$) contributes.

Therefore, the signed area over one period is exactly $\frac{2\pi}{T}$, independently of $N$.

In the distributional limit, the Dirichlet kernel converges to a periodic impulse train whose impulse weight is $\frac{2\pi}{T}$:

$$
\boxed{
\lim_{N\to\infty} S_N(\omega)
=
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

---

### 2.4 The Fourier Series Proof of the Identity

The same identity can be established directly using the Fourier series of a periodic Dirac comb.

Let $\Omega = \frac{2\pi}{T}$. The periodic Dirac comb distribution

$$
\operatorname{III}_{\Omega}(\omega) = \sum_{k=-\infty}^{\infty} \delta(\omega - k\Omega)
$$

has the complex Fourier series representation:

$$
\operatorname{III}_{\Omega}(\omega) = \sum_{n=-\infty}^{\infty} c_n e^{inT\omega}.
$$

To find the Fourier coefficients $c_n$, integrate over one period $\left[-\frac{\Omega}{2}, \frac{\Omega}{2}\right]$:

$$
\begin{aligned}
c_n
&= \frac{1}{\Omega} \int_{-\Omega/2}^{\Omega/2} \operatorname{III}_{\Omega}(\omega) e^{-inT\omega} \, d\omega \\
&= \frac{1}{\Omega} \\
&= \frac{T}{2\pi}.
\end{aligned}
$$

The integration interval contains exactly one impulse, at $\omega = 0$, and the complex exponential evaluates to $1$ there.

Consequently,

$$
\begin{aligned}
\sum_{k=-\infty}^{\infty} \delta\left(\omega - \frac{2\pi k}{T}\right)
&= \frac{T}{2\pi} \sum_{n=-\infty}^{\infty} e^{inT\omega} \\
&= \frac{T}{2\pi} \sum_{n=-\infty}^{\infty} e^{-inT\omega},
\end{aligned}
$$

where the final equality follows by replacing $n$ with $-n$.

Rearranging gives the required identity:

$$
\boxed{
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

All infinite-series identities above are understood in the sense of tempered distributions.

---

### 2.5 Completing the DTFT Proof: Spectral Replication and Aliasing

With the distributional identity established, we substitute it back into our DTFT relation from Section 2.2:

$$
\begin{aligned}
X_s(\omega) 
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \left( \sum_{n=-\infty}^{\infty} e^{-inT(\omega - \theta)} \right) d\theta \\
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \left[ \frac{2\pi}{T} \sum_{k=-\infty}^{\infty} \delta\left(\omega - \theta - \frac{2\pi k}{T}\right) \right] d\theta \\
&= \frac{1}{T} \sum_{k=-\infty}^{\infty} \int_{-\infty}^{\infty} X(\theta) \, \delta\left(\theta - \left(\omega - \frac{2\pi k}{T}\right)\right) d\theta
\end{aligned}
$$

Applying the sifting property of the Dirac delta yields the fundamental **DTFT Spectral Replication Theorem** (Poisson Summation Formula in the frequency domain):

$$
\boxed{
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) e^{-inT\omega} = \frac{1}{T} \sum_{k=-\infty}^{\infty} X\left(\omega - \frac{2\pi k}{T}\right)
}
$$

**Physical Takeaway:** Sampling a continuous signal $x(t)$ at intervals of $T$ scales its continuous Fourier spectrum by $\frac{1}{T}$ and replicates it periodically at integer multiples of the sampling frequency $\Omega = \frac{2\pi}{T}$. If the continuous signal $x(t)$ is band-limited to $|\omega| < \frac{\pi}{T}$ (the **Nyquist limit**), the shifted spectral copies remain mutually disjoint, allowing exact continuous reconstruction. If higher frequencies are present, adjacent copies overlap—producing **spectral aliasing**.