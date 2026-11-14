---
layout: post
title: "Theory for Analyzing Brain Signals: The Fourier Transform"
date: 2026-04-01
categories: [signal-processing, mathematics, neuroscience]
permalink: /posts/fourier-transform-theory-and-neural-applications.html
excerpt: "An intuitive yet rigorous journey through the Fourier Transform: from the geometric complex-winding picture and physical units in neural recordings, to the complete 6-step Gaussian regularization proof of the Fourier Inversion Theorem, and finally Dirac-comb sampling, the Dirichlet kernel, and spectral aliasing in electrophysiology and fMRI."
outline:
  - title: "The Continuous-Time Fourier Transform (CTFT): Intuition, Conventions & Inversion Proof"
    url: "#1-the-continuous-time-fourier-transform-ctft"
  - title: "Interactive Zoom Explorer: The Sifting Property ∫ f(x) δ(x − x₀) dx = f(x₀)"
    url: "#1-5-sifting-property-zoom"
  - title: "Discrete-Time Fourier Transform (DTFT): Sampling, The Crucial Identity & Aliasing"
    url: "#2-discrete-time-fourier-transform-dtft"
---

When we place a recording electrode into cortical tissue to measure a **Local Field Potential (LFP)**, fit an **EEG** cap on the scalp, or acquire **fMRI BOLD** time series across the brain, nature hands us a single value $x(t)$ at each moment in time $t$. Yet beneath that single fluctuating trace, dozens of neural processes are operating *simultaneously* across different timescales: slow **delta and theta rhythms** ($1\text{–}8\text{ Hz}$) coordinating long-range networks, **alpha oscillations** ($8\text{–}12\text{ Hz}$) gating sensory attention, and fast **gamma bursts** ($30\text{–}80\text{ Hz}$) driving local circuit computation.

In the **time domain**, all of these rhythms are summed on top of one another at every millisecond. Looking at a raw voltage trace $x(t)$ is like listening to an entire orchestra by staring at the single wiggly groove carved into a vinyl record. How do we untangle that single groove back into the individual instruments?

The **Fourier Transform** is the mathematical prism that solves this problem. Just as a glass prism bends white light into its constituent wavelengths, the Fourier Transform provides an **exact, invertible dictionary** between two equivalent views of the same signal:
- **The Time Domain $x(t)$:** *"What is the signal's amplitude at each instant $t$?"*
- **The Frequency Domain $X(f)$:** *"How much of each pure oscillation frequency $f$ is present across the entire signal, and at what phase alignment?"*

In this exposition, we build the complete mathematical framework from first principles—pairing every equation and proof step with clear geometric and physical intuition:
1. **[The Continuous-Time Fourier Transform (CTFT)](#1-the-continuous-time-fourier-transform-ctft)** — How multiplying by a spinning complex exponential $e^{-i 2\pi f t}$ extracts frequencies via constructive interference, why three different $2\pi$ conventions exist, what physical units $X(f)$ carries in neuroscience, and the **complete 6-step Gaussian regularization proof of the Fourier Inversion Theorem**.
2. **[The Discrete-Time Fourier Transform (DTFT) & Sampling Theory](#2-discrete-time-fourier-transform-dtft)** — How we transition from continuous brain waves $x(t)$ to digital samples $x(nT)$ via a **Dirac impulse train** $s(t)$, why an infinite sum of complex exponentials collapses into a periodic Dirac comb via the **Dirichlet kernel**, and how this proves the **Spectral Replication & Nyquist–Shannon Aliasing Theorem**.

---

## 1. The Continuous-Time Fourier Transform (CTFT)
<a id="1-the-continuous-time-fourier-transform-ctft"></a>

Before writing down the integral, let us ask a fundamental design question: **If someone hands you a complicated signal $x(t)$, how would you build a mathematical detector that measures how much of a specific frequency $f$ lives inside $x(t)$?**

### 1.1 The Core Geometric Intuition: Template Matching & Winding in the Complex Plane

We can understand the Continuous-Time Fourier Transform through three intuitive ideas:

#### Idea 1: Continuous Inner Product (Projecting onto Pure Waves)
In finite-dimensional linear algebra, if you have a vector $\vec{v} \in \mathbb{R}^3$ and want to know how much of it points along a unit basis direction $\hat{e}_k$, you take the **dot product** $\langle \vec{v}, \hat{e}_k \rangle = \sum_n v_n (e_k)_n$: multiply matching coordinates and add them up.

A continuous-time signal $x(t)$ is simply a vector in an infinite-dimensional function space, where every instant $t \in (-\infty, \infty)$ is a coordinate index. Our "unit basis vectors" are everlasting pure oscillations $e^{i 2\pi f t}$ of frequency $f$. To measure how strongly $x(t)$ aligns with the basis wave at frequency $f$, we take their **Hermitian inner product**—multiplying $x(t)$ by the complex conjugate of the basis wave, $e^{-i 2\pi f t}$, and integrating over all time:

$$
X(f) = \langle x(t), e^{i 2\pi f t} \rangle = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} \, dt
$$

#### Idea 2: Why Complex Exponentials $e^{-i 2\pi f t}$ Instead of Just $\cos(2\pi f t)$?
A natural question arises: *Why bring complex numbers ($i = \sqrt{-1}$) into the analysis of a real-valued voltage recording $x(t)$? Why not just multiply $x(t)$ by $\cos(2\pi f t)$ and integrate?*

Suppose a cortical circuit is oscillating strongly at $f_0 = 10\text{ Hz}$, but its wave happens to start at zero and rise—meaning it is a **sine wave**, $x(t) = \sin(2\pi f_0 t) = \cos\left(2\pi f_0 t - \frac{\pi}{2}\right)$, shifted by a quarter-cycle ($90^\circ$) relative to a cosine. If we probed $x(t)$ using only $\cos(2\pi f_0 t)$, their product $\sin(2\pi f_0 t)\cos(2\pi f_0 t) = \frac{1}{2}\sin(4\pi f_0 t)$ would oscillate symmetrically above and below zero and integrate to **exact zero**! A cosine-only detector is completely blind to sine waves.

Euler's formula solves this phase blind-spot effortlessly by packing **two orthogonal detectors** into a single complex number:

$$
e^{-i 2\pi f t} = \underbrace{\cos(2\pi f t)}_{\substack{\text{In-Phase Probe} \\ \text{(detects peaks at } t=0\text{)}}} - \; i \underbrace{\sin(2\pi f t)}_{\substack{\text{Quadrature Probe} \\ \text{(detects } 90^\circ\text{-shifted peaks)}}}
$$

By projecting $x(t)$ onto $\cos(2\pi f t)$ (the real axis) and $-\sin(2\pi f t)$ (the imaginary axis) simultaneously:
- The **magnitude** $\lvert X(f)\rvert = \sqrt{[\operatorname{Re} X(f)]^2 + [\operatorname{Im} X(f)]^2}$ measures the total amplitude density at frequency $f$, **completely independent of when the wave started**.
- The **angle** $\arg(X(f)) = \operatorname{atan2}(\operatorname{Im} X(f), \operatorname{Re} X(f))$ tells us the exact **starting phase** of that oscillation.

#### Idea 3: The Complex Winding Machine (Center-of-Mass Resonance)
Geometrically, $e^{-i 2\pi f t}$ is a unit vector in the complex plane that starts at $1 + 0i$ at $t=0$ and **spins clockwise** at $f$ full revolutions per second. Multiplying $x(t)$ by $e^{-i 2\pi f t}$ literally **winds the graph of $x(t)$ around the origin of the complex plane** at winding rate $f$, and the integral $\int x(t) e^{-i 2\pi f t}\,dt$ measures the **net center of mass** of that wound-up curve:

- **Off-Resonance ($f \neq f_{\text{signal}}$ — Destructive Interference):** When our winding frequency $f$ does not match an oscillation in $x(t)$, the positive peaks of $x(t)$ land at constantly shifting angles around the circle. Over time, points on the wound-up curve distribute symmetrically in all directions around the origin, pulling equally left, right, up, and down. The integral cancels out to zero.
- **On-Resonance ($f = f_{\text{signal}}$ — Constructive Interference):** When our winding rate $f$ exactly matches an intrinsic rhythm $f_0$ inside $x(t)$, every time the signal $x(t)$ reaches a crest, the spinning phasor $e^{-i 2\pi f_0 t}$ has completed an exact full turn back to the **same angle** in the complex plane! Every cycle reinforces the previous cycle in the exact same direction, shifting the center of mass strongly away from the origin and producing a sharp spectral peak $X(f_0)$.

<figure class="diagram-figure">
<svg viewBox="0 0 820 310" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Geometric intuition of the Fourier Transform: off-resonance cancellation versus on-resonance constructive alignment in the complex plane, and spectral decomposition of a composite brain signal.">
  <defs>
    <marker id="arr-blue" viewBox="0 0 10 10" refX="7" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 10 5 L 0 9 z" fill="#2563eb"/>
    </marker>
    <marker id="arr-emerald" viewBox="0 0 10 10" refX="7" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 10 5 L 0 9 z" fill="#10b981"/>
    </marker>
    <marker id="arr-amber" viewBox="0 0 10 10" refX="7" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 10 5 L 0 9 z" fill="#f59e0b"/>
    </marker>
  </defs>

  <!-- Panel 1: Off-Resonance Winding -->
  <rect x="12" y="12" width="250" height="286" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="137" y="36" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">A. Off-Resonance (f ≠ f₀)</text>
  <text x="137" y="53" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Wound curve loops symmetrically</text>

  <!-- Complex Axes Panel 1 -->
  <line x1="42" y1="155" x2="232" y2="155" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="137" y1="70" x2="137" y2="240" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="3,3"/>
  <text x="228" y="148" text-anchor="end" font-size="10" fill="var(--text-muted)">Re</text>
  <text x="144" y="80" font-size="10" fill="var(--text-muted)">Im</text>

  <!-- Symmetric Spirograph / Rose curve around origin -->
  <path d="M 202 155 C 202 110, 155 120, 137 90 C 119 120, 72 110, 72 155 C 72 200, 119 190, 137 220 C 155 190, 202 200, 202 155 Z" fill="rgba(37, 99, 235, 0.08)" stroke="#3b82f6" stroke-width="2"/>
  <path d="M 183 109 C 145 125, 129 95, 91 109 C 107 145, 80 165, 91 201 C 129 185, 145 215, 183 201 C 167 165, 195 145, 183 109 Z" fill="none" stroke="#60a5fa" stroke-width="1.4" stroke-dasharray="4,2"/>
  <circle cx="137" cy="155" r="5" fill="#ef4444"/>
  <text x="137" y="264" text-anchor="middle" font-size="11" font-weight="600" fill="var(--text-secondary)">Phasors cancel in all directions</text>
  <text x="137" y="281" text-anchor="middle" font-size="11.5" font-weight="700" fill="#ef4444">∫ x(t) e⁻ⁱ²πᶠᵗ dt ≈ 0</text>

  <!-- Panel 2: On-Resonance Winding -->
  <rect x="285" y="12" width="250" height="286" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="410" y="36" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">B. On-Resonance (f = f₀)</text>
  <text x="410" y="53" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Peaks lock to the same phase angle</text>

  <!-- Complex Axes Panel 2 -->
  <line x1="315" y1="155" x2="505" y2="155" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="3,3"/>
  <line x1="385" y1="70" x2="385" y2="240" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="3,3"/>
  <text x="501" y="148" text-anchor="end" font-size="10" fill="var(--text-muted)">Re</text>
  <text x="392" y="80" font-size="10" fill="var(--text-muted)">Im</text>

  <!-- Off-center Cardioid / Shifted loop (Constructive pile-up) -->
  <path d="M 385 155 C 395 105, 485 95, 492 142 C 498 188, 405 198, 385 155 Z" fill="rgba(16, 185, 129, 0.14)" stroke="#10b981" stroke-width="2.2"/>
  <path d="M 385 155 C 400 112, 478 102, 485 142 C 490 180, 410 190, 385 155 Z" fill="none" stroke="#34d399" stroke-width="1.3" stroke-dasharray="3,2"/>
  <!-- Vector from origin to Center of Mass -->
  <line x1="385" y1="155" x2="452" y2="144" stroke="#f59e0b" stroke-width="2.5" marker-end="url(#arr-amber)"/>
  <circle cx="456" cy="143" r="5" fill="#f59e0b"/>
  <text x="456" y="128" text-anchor="middle" font-size="10.5" font-weight="700" fill="#d97706">X(f₀)</text>
  <text x="410" y="264" text-anchor="middle" font-size="11" font-weight="600" fill="var(--text-secondary)">Crests pile up constructively</text>
  <text x="410" y="281" text-anchor="middle" font-size="11.5" font-weight="700" fill="#10b981">|X(f₀)| ≫ 0, Phase = arg X(f₀)</text>

  <!-- Panel 3: Resulting Amplitude Spectrum |X(f)| -->
  <rect x="558" y="12" width="250" height="286" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="683" y="36" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">C. Neural Spectrum |X(f)|</text>
  <text x="683" y="53" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Unmixing cortical rhythms</text>

  <!-- Spectrum Axes -->
  <line x1="585" y1="225" x2="788" y2="225" stroke="var(--text-secondary)" stroke-width="1.5"/>
  <line x1="585" y1="225" x2="585" y2="75" stroke="var(--text-secondary)" stroke-width="1.5"/>
  <text x="786" y="242" text-anchor="end" font-size="10" fill="var(--text-muted)">f (Hz)</text>
  <text x="592" y="84" font-size="10" fill="var(--text-muted)">|X(f)|</text>

  <!-- Spectral Peaks: Theta (6 Hz), Alpha (10 Hz), Gamma (40 Hz) -->
  <path d="M 586 224 L 605 223 Q 615 222 620 140 Q 625 222 635 223 Q 648 222 656 92 Q 664 222 678 223 L 720 223 Q 732 222 740 162 Q 748 222 760 223 L 784 224" fill="rgba(37, 99, 235, 0.15)" stroke="#2563eb" stroke-width="2.2"/>

  <!-- Peak labels -->
  <circle cx="620" cy="140" r="3.5" fill="#2563eb"/>
  <text x="618" y="128" text-anchor="middle" font-size="9.5" font-weight="700" fill="#2563eb">θ (6 Hz)</text>

  <circle cx="656" cy="92" r="4" fill="#10b981"/>
  <text x="658" y="80" text-anchor="middle" font-size="9.5" font-weight="700" fill="#10b981">α (10 Hz)</text>

  <circle cx="740" cy="162" r="3.5" fill="#d97706"/>
  <text x="740" y="150" text-anchor="middle" font-size="9.5" font-weight="700" fill="#d97706">γ (40 Hz)</text>

  <text x="683" y="264" text-anchor="middle" font-size="11" font-weight="600" fill="var(--text-secondary)">Each rhythm separates cleanly</text>
  <text x="683" y="281" text-anchor="middle" font-size="11" font-weight="600" fill="var(--brand-primary)">Time tangle → Frequency peaks</text>
</svg>
<figcaption class="diagram-caption">
  <strong>Figure 1 — Geometric Intuition of the Continuous-Time Fourier Transform.</strong> <strong>(A)</strong> When the probing frequency $f$ does not match any rhythm in $x(t)$, winding $x(t)e^{-i2\pi f t}$ in the complex plane produces a symmetric trajectory whose center of mass stays near the origin ($X(f) \approx 0$). <strong>(B)</strong> When $f$ matches an intrinsic oscillation $f_0$, consecutive wave crests align at the same angle, shifting the center of mass to a large complex vector $X(f_0)$. <strong>(C)</strong> Sweeping $f$ across all frequencies acts as a prism that separates a tangled cortical recording into distinct Theta ($\theta$), Alpha ($\alpha$), and Gamma ($\gamma$) peaks.
</figcaption>
</figure>

---

### 1.2 The Mathematical Definition & Normalization Conventions

Under the **linear frequency** ($f$, measured in Hertz or cycles per second) convention, the forward **Continuous-Time Fourier Transform (CTFT)** is defined as:

$$
X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} \, dt
$$

and the original continuous-time signal is reconstructed via the **Continuous Inverse Fourier Transform (IFT)**:

$$
x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} \, df
$$

<div class="intuition-box" markdown="1">
<div class="callout-header">💡 Why Opposite Signs ($-i$ vs. $+i$) in the Forward and Inverse Transforms?</div>

Think of the sign in the exponent as **unwinding vs. rewinding**:
- **Analysis (Forward Transform, $e^{-i 2\pi f t}$):** If $x(t)$ contains a wave spinning forward at $e^{+i 2\pi f_0 t}$, multiplying by $e^{-i 2\pi f t}$ at $f = f_0$ **stops the rotation** ($e^{i 2\pi f_0 t} \cdot e^{-i 2\pi f_0 t} = e^0 = 1$), freezing the wave in place so the time integral can accumulate its constant complex amplitude $X(f_0)$.
- **Synthesis (Inverse Transform, $e^{+i 2\pi f t}$):** Once we know the complex weight $X(f)\,df$ of every frequency slice, we multiply it back by the forward-spinning wave $e^{+i 2\pi f t}$ and sum (integrate) over all frequencies $f \in (-\infty, \infty)$ to reassemble $x(t)$.
</div>

#### Angular Frequency Form ($\omega = 2\pi f$) & Where the $\frac{1}{2\pi}$ Comes From

In theoretical physics, differential equations, and control theory, it is often cleaner to work with **radian angular frequency** $\omega = 2\pi f$ (measured in $\text{radians/s}$) so that we write $e^{-i\omega t}$ instead of carrying $2\pi$ inside every exponent.

Why does switching from $f$ to $\omega$ introduce a factor of $\frac{1}{2\pi}$? It comes directly from the **calculus change of variables** in the inverse integral: since $\omega = 2\pi f$, a $1\text{ Hz}$ frequency interval corresponds to $2\pi\text{ radians/s}$ of angular frequency ($d\omega = 2\pi \, df \implies df = \frac{d\omega}{2\pi}$). Stretching the horizontal frequency axis by a factor of $2\pi$ multiplies the area under the spectrum by $2\pi$; therefore, we must divide by $2\pi$ so the reconstructed signal $x(t)$ maintains its true amplitude.

Depending on how we bookkeep that $\frac{1}{2\pi}$ factor, two standard angular-frequency conventions arise:

1. **Symmetric Unitary Convention (Quantum Mechanics & Functional Analysis):**  
   We split the $\frac{1}{2\pi}$ factor symmetrically as $\frac{1}{\sqrt{2\pi}}$ on both the forward and inverse transforms so that both operators are **unitary isometries** on $L^2(\mathbb{R})$:

   $$
   X(\omega) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt, \qquad x(t) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega
   $$

2. **Non-Unitary Angular Convention (Signal Processing & Linear Systems):**  
   We keep the forward transform unscaled (so the impulse response $\delta(t)$ transforms to $1$) and place the entire $\frac{1}{2\pi}$ factor on the inverse integral:

   $$
   X(\omega) = \int_{-\infty}^{\infty} x(t) e^{-i \omega t} \, dt, \qquad x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} \, d\omega
   $$

| Convention | Forward Transform | Inverse Transform | Primary Advantage |
| :--- | :--- | :--- | :--- |
| **Linear Frequency ($f$, Hz)** | $\displaystyle \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t}\,dt$ | $\displaystyle \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t}\,df$ | **No prefactors ($1$ on both)**; $f$ is directly in experimental $\text{Hz}$ |
| **Unitary Angular ($\omega$, rad/s)** | $\displaystyle \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} x(t) e^{-i \omega t}\,dt$ | $\displaystyle \frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} X(\omega) e^{i \omega t}\,d\omega$ | **Exact symmetry** between forward & inverse operators |
| **Signal Processing ($\omega$, rad/s)** | $\displaystyle \int_{-\infty}^{\infty} x(t) e^{-i \omega t}\,dt$ | $\displaystyle \frac{1}{2\pi}\int_{-\infty}^{\infty} X(\omega) e^{i \omega t}\,d\omega$ | Cleanest convolution & LTI transfer functions: $\mathcal{F}\{\delta(t)\} = 1$ |

---

### 1.3 Variables, Physical Units & Why $X(f)$ Is a Spectral Density

To ground these abstract symbols in real experimental data—such as an extracellular Local Field Potential (LFP) or intracellular membrane potential recording—let us track the exact physical dimensions of every term:

- **$x(t)$**: The continuous time-domain signal (e.g., neural voltage measured in millivolts, $\text{mV}$).
- **$t$**: Continuous time measured in seconds ($\text{s}$).
- **$dt$**: Infinitesimal time integration step ($\text{s}$).
- **$f$**: Linear oscillation frequency in cycles per second ($\text{Hz} = \text{s}^{-1}$).
- **$\omega$**: Radian angular frequency ($\text{rad/s}$), related to linear frequency by $\omega = 2\pi f$.
- **$X(f)$**: The complex Fourier transform evaluated at frequency $f$.

<div class="neuro-box" markdown="1">
<div class="callout-header">🧠 Neuroscience Lens: Why Are the Units of $|X(f)|$ Equal to $\text{mV}/\text{Hz}$ Instead of $\text{mV}$?</div>

Look closely at the forward integral $X(f) = \int x(t) e^{-i 2\pi f t}\,dt$:
- $x(t)$ has units of **millivolts ($\text{mV}$)**.
- $e^{-i 2\pi f t}$ is **dimensionless** (radians cancel: $[\text{s}^{-1}] \times [\text{s}] = 1$).
- $dt$ has units of **seconds ($\text{s} = \text{Hz}^{-1}$)**.

Therefore, $X(f)$ has units of **$\text{mV}\cdot\text{s} = \frac{\text{mV}}{\text{Hz}}$**—an **amplitude spectral density**, not a voltage!

**Intuition:** Just as a continuous probability density $p(x)$ only yields a probability when multiplied by an interval width $dx$, in a continuous spectrum no single mathematical point frequency $f$ carries finite voltage on its own. Instead, $|X(f)|\,df$ tells you how many millivolts of oscillation live inside the narrow frequency band $[f, f+df]$:

$$
\underbrace{|X(f)|}_{\left[\frac{\text{mV}}{\text{Hz}}\right]} \times \underbrace{df}_{[\text{Hz}]} = \text{Voltage contribution in band } [f, f+df] \;\; [\text{mV}]
$$

In empirical electrophysiology (EEG/LFP), we often plot the **Power Spectral Density (PSD)**, which is proportional to $|X(f)|^2$ per unit recording time and carries units of **$\frac{\text{mV}^2}{\text{Hz}}$** (or $\frac{\mu\text{V}^2}{\text{Hz}}$), quantifying how the brain's electrical variance is distributed across frequency bands.
</div>

---

### 1.4 Proof of the Fourier Inversion Theorem

We now confront the central theoretical question of Section 1: **Why does plugging the spectrum $X(f)$ back into the inverse integral faithfully reconstruct the exact value of $x(t)$ at every instant $t$, without any cross-talk from other time points $\tau \neq t$?**

#### The Intuitive Roadmap Before the Algebra

When we substitute the definition of $X(f) = \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau}\,d\tau$ into the inverse transform $x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t}\,df$ and interchange the order of integration, we get:

$$
x(t) = \int_{-\infty}^{\infty} x(\tau) \underbrace{\left( \int_{-\infty}^{\infty} e^{i 2\pi f (t - \tau)} \, df \right)}_{\mathcal{K}(t - \tau)} d\tau
$$

Look at what the inner integral $\mathcal{K}(t - \tau) = \int_{-\infty}^{\infty} e^{i 2\pi f (t - \tau)}\,df$ is doing: it sums pure waves of **every possible frequency $f \in (-\infty, \infty)$** evaluated at the time lag $u = t - \tau$:
1. **At the exact target instant $\tau = t$ (zero time lag, $u = 0$):**  
   Every single frequency has zero phase shift: $e^{i 2\pi f (0)} = \cos(0) = 1$. Every wave across the entire infinite frequency spectrum reaches its crest $+1$ **at the exact same moment**! Adding $+1$ across all $f \in (-\infty, \infty)$ produces an infinitely tall constructive spike at $\tau = t$.
2. **At every other time $\tau \neq t$ (nonzero time lag, $u \neq 0$):**  
   As frequency $f$ varies continuously, $\cos(2\pi f u)$ oscillates rapidly between $+1$ and $-1$. Positive and negative half-cycles cancel each other out across the frequency spectrum (**destructive interference**), so no other time point $\tau \neq t$ can leak into $x(t)$!

**The Mathematical Obstacle & The Gaussian Solution:**  
Although $\int_{-\infty}^{\infty} \cos(2\pi f u)\,df$ cancels out intuitively for $u \neq 0$, the integrand $\cos(2\pi f u)$ never decays to zero as $f \to \pm\infty$—it oscillates forever, so the improper Riemann integral does not converge classically!

How do we make this completely rigorous? We introduce a **Gaussian convergence factor (soft low-pass filter)** $e^{-a f^2}$ with $a > 0$:

$$
I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) \, e^{-a f^2} \, df
$$

Physically, $e^{-a f^2}$ acts like a smooth **frequency window** of bandwidth $\propto 1/\sqrt{a}$ that gently damps infinite frequencies so the integral converges absolutely. As we prove below in Steps 3–5, the Fourier integral of a wide Gaussian in frequency ($e^{-a f^2}$) is a **narrow Gaussian bell curve in time**:

$$
I_a(u) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left(-\frac{u^2}{2\sigma^2}\right) \quad \text{with variance } \sigma^2 = \frac{a}{2\pi^2} \text{ and total area } = 1.
$$

Then, as we open the frequency window to infinite bandwidth ($a \to 0^+$), the time-domain variance $\sigma^2 \to 0$: the Gaussian bell curve squeezes into an infinitely narrow, infinitely tall spike of area $1$—the **Dirac delta distribution $\delta(t - \tau)$**!

<figure class="diagram-figure">
<svg viewBox="0 0 820 285" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Visualizing Gaussian regularization in the Fourier Inversion Theorem proof: frequency-domain damped cosine versus time-domain narrowing Gaussian approaching the Dirac delta.">
  <!-- Left Panel: Frequency Domain Integrand -->
  <rect x="12" y="12" width="385" height="261" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="204" y="36" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">1. Frequency Domain: Gaussian Damping e⁻ᵃᶠ²</text>
  <text x="204" y="53" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Tames the infinite oscillations of cos(2πfu) for a &gt; 0</text>

  <!-- Axes Left -->
  <line x1="35" y1="165" x2="375" y2="165" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <line x1="205" y1="70" x2="205" y2="235" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <text x="372" y="180" text-anchor="end" font-size="10" fill="var(--text-muted)">f</text>
  <text x="212" y="80" font-size="10" fill="var(--text-muted)">Amplitude</text>

  <!-- Upper & Lower Gaussian Envelope +/- e^{-a f^2} -->
  <path d="M 45 162 C 110 160, 155 82, 205 82 C 255 82, 300 160, 365 162" fill="none" stroke="#f59e0b" stroke-width="2" stroke-dasharray="5,3"/>
  <path d="M 45 168 C 110 170, 155 248, 205 248 C 255 248, 300 170, 365 168" fill="none" stroke="#f59e0b" stroke-width="1.5" stroke-dasharray="5,3"/>
  <text x="295" y="102" font-size="10.5" font-weight="700" fill="#d97706">Envelope ±e⁻ᵃᶠ²</text>

  <!-- Damped Cosine Wave inside envelope -->
  <path d="M 45 165 Q 55 162 65 165 T 85 165 Q 95 173 105 165 Q 115 150 125 165 Q 135 190 145 165 Q 155 125 165 165 Q 175 220 185 165 Q 195 82 205 82 Q 215 82 225 165 Q 235 220 245 165 Q 255 125 265 165 Q 275 190 285 165 Q 295 150 305 165 Q 315 173 325 165 T 345 165 Q 355 162 365 165" fill="none" stroke="#2563eb" stroke-width="2"/>
  <text x="204" y="258" text-anchor="middle" font-size="11" font-weight="600" fill="#2563eb">Integrand: cos(2πfu) · e⁻ᵃᶠ² ∈ L¹(ℝ)</text>

  <!-- Right Panel: Time-Lag Domain Gaussian -> Dirac Delta -->
  <rect x="423" y="12" width="385" height="261" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="615" y="36" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">2. Time-Lag Domain: Iₐ(u) → δ(t − τ) as a → 0⁺</text>
  <text x="615" y="53" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Variance σ² = a/(2π²) shrinks while area stays 1</text>

  <!-- Axes Right -->
  <line x1="448" y1="225" x2="785" y2="225" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <line x1="615" y1="68" x2="615" y2="235" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <text x="782" y="242" text-anchor="end" font-size="10" fill="var(--text-muted)">u = t − τ</text>
  <text x="615" y="244" text-anchor="middle" font-size="10" font-weight="700" fill="var(--text-heading)">0</text>

  <!-- Curve 1: Large a (Wide Gaussian) -->
  <path d="M 465 224 C 525 223, 565 175, 615 175 C 665 175, 705 223, 765 224" fill="none" stroke="#94a3b8" stroke-width="1.8" stroke-dasharray="4,3"/>
  <text x="708" y="196" font-size="10" font-weight="600" fill="var(--text-muted)">Large a</text>

  <!-- Curve 2: Medium a (Medium Gaussian) -->
  <path d="M 495 224 C 555 224, 582 132, 615 132 C 648 132, 675 224, 735 224" fill="rgba(59, 130, 246, 0.10)" stroke="#3b82f6" stroke-width="2"/>
  <text x="675" y="158" font-size="10" font-weight="600" fill="#3b82f6">Small a</text>

  <!-- Curve 3: Tiny a -> Dirac Delta Spike -->
  <path d="M 555 224 C 595 224, 604 74, 615 74 C 626 74, 635 224, 675 224" fill="rgba(16, 185, 129, 0.18)" stroke="#10b981" stroke-width="2.4"/>
  <text x="668" y="92" font-size="10.5" font-weight="700" fill="#10b981">a → 0⁺ : δ(u)</text>

  <text x="615" y="260" text-anchor="middle" font-size="11" font-weight="600" fill="#10b981">∫ Iₐ(u) du = 1 for all a &gt; 0  ⟹  lim Iₐ(t − τ) = δ(t − τ)</text>
</svg>
<figcaption class="diagram-caption">
  <strong>Figure 2 — Gaussian Regularization &amp; Time-Frequency Duality in the Inversion Theorem Proof.</strong> <strong>(1)</strong> Multiplying $\cos(2\pi f u)$ by the Gaussian envelope $e^{-a f^2}$ ($a > 0$) makes the oscillatory frequency integral absolutely convergent. <strong>(2)</strong> Its exact integral in the time-lag variable $u = t - \tau$ is a normalized Gaussian bell curve $I_a(u)$ of variance $\sigma^2 = \frac{a}{2\pi^2}$ and unit area. As the damping vanishes ($a \to 0^+$), $I_a(u)$ sharpens into the Dirac delta distribution $\delta(t - \tau)$.
</figcaption>
</figure>

<details open markdown="1">
<summary><strong>Click to view / collapse the complete 6-step mathematical proof of the Fourier Inversion Theorem</strong></summary>

<br>

#### Step 1: Setting Up the Inversion Identity

Substitute the definition of the forward transform $X(f)$ directly into the inverse formula, using a dummy time variable $\tau$ inside the forward integral so we do not confuse it with the target reconstruction time $t$:

$$
x(t) = \int_{-\infty}^{\infty}
\left(
\int_{-\infty}^{\infty}
x(\tau)e^{-i2\pi f\tau}\,d\tau
\right)e^{i2\pi ft}\,df
$$

Assume that $x:\mathbb{R}\to\mathbb{C}$ is an absolutely integrable function ($x\in L^1(\mathbb{R})$), i.e.,

$$
\int_{-\infty}^{\infty}|x(t)|\,dt < \infty.
$$

Interchanging the order of integration formally using Fubini's theorem (which we justify rigorously via the Gaussian regularization factor introduced in Step 2) gives:

$$
x(t) = \int_{-\infty}^{\infty}x(\tau)
\left(
\int_{-\infty}^{\infty}
e^{i2\pi f(t-\tau)}\,df
\right)d\tau.
$$

Define the time displacement (lag) variable between our reconstruction time $t$ and source time $\tau$:

$$
u = t - \tau.
$$

We must now evaluate the inner oscillatory integral—the **inversion kernel**:

$$
\mathcal{K}(u) = \int_{-\infty}^{\infty}e^{i2\pi fu}\,df.
$$

Our goal is to prove that in the distributional sense, $\mathcal{K}(u) = \delta(u) = \delta(t - \tau)$.

---

#### Step 2: Euler's Formula & Introducing the Gaussian Regularizer

Expanding $e^{i 2\pi f u}$ via Euler's formula $e^{i \theta} = \cos\theta + i \sin\theta$:

$$
\int_{-\infty}^{\infty} e^{i 2\pi f u} \, df = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df + i \int_{-\infty}^{\infty} \sin(2\pi f u) \, df
$$

Because $\sin(2\pi f u)$ is an **odd function** of $f$ ($\sin(-2\pi f u) = -\sin(2\pi f u)$) integrated over the symmetric domain $(-\infty, \infty)$, the left and right halves cancel identically:

$$
\int_{-\infty}^{\infty} \sin(2\pi f u) \, df = 0
$$

The remaining cosine integral $\int_{-\infty}^{\infty} \cos(2\pi f u) \, df$ is even, but oscillates forever as $f \to \pm\infty$ without converging in the standard Riemann sense. To evaluate it rigorously, we multiply the integrand by a **Gaussian convergence factor** $e^{-a f^2}$ with parameter $a > 0$:

$$
I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) \, e^{-a f^2} \, df
$$

Notice two crucial properties of $e^{-a f^2}$:
1. For any fixed $a > 0$, $e^{-a f^2}$ decays super-exponentially as $f \to \pm\infty$, making the double integral in Step 1 absolutely integrable so Fubini's theorem holds without question.
2. In the limit $a \to 0^+$, the damping factor $e^{-a f^2} \to 1$ pointwise at every frequency $f$.

---

#### Step 3: Differentiating Under the Integral Sign (Feynman's Trick)

How do we compute $I_a(u)$ in closed form? Notice that differentiating $\cos(2\pi f u)$ with respect to $u$ pulls down a factor of $-2\pi f$. That extra factor of $f$ is a gift: when paired with the Gaussian $e^{-a f^2}$, the product $-2\pi f e^{-a f^2}$ has an elementary antiderivative $\frac{\pi}{a} e^{-a f^2}$!

Differentiating $I_a(u)$ with respect to $u$ using Leibniz's rule:

$$
\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} \, df
$$

Now apply integration by parts, $\int U \, dV = UV - \int V \, dU$, with the choices:

$$
\text{Let } U = \sin(2\pi f u) \implies dU = 2\pi u \cos(2\pi f u) \, df
$$

$$
\text{Let } dV = -2\pi f e^{-a f^2} \, df \implies V = \frac{\pi}{a} e^{-a f^2}
$$

Evaluating the boundary term at $f = \pm\infty$, the bounded sine function is crushed to zero by the Gaussian $e^{-a f^2}$:

$$
\left[ U V \right]_{f=-\infty}^{f=\infty} = \left[ \frac{\pi}{a} \sin(2\pi f u) e^{-a f^2} \right]_{f=-\infty}^{f=\infty} = 0
$$

Therefore, only the $-\int V \, dU$ integral survives:

$$
\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df = -\frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} \, df
$$

Recognizing our original integral $I_a(u)$ on the right-hand side yields a clean differential equation:

$$
\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)
$$

---

#### Step 4: Solving the Differential Equation

This is a first-order separable ordinary differential equation for $I_a(u)$. Separating variables:

$$
\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} \, du
$$

Integrating both sides with respect to $u$:

$$
\ln I_a(u) = -\frac{\pi^2 u^2}{a} + C' \implies I_a(u) = C \exp\left( -\frac{\pi^2 u^2}{a} \right)
$$

To determine the integration constant $C$, set $u = 0$ in the definition of $I_a(u)$ (where $\cos(0) = 1$), which reduces to the classic Gaussian integral:

$$
C = I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} \, df = \sqrt{\frac{\pi}{a}}
$$

Substituting $C = \sqrt{\frac{\pi}{a}}$ gives the exact closed-form expression for the regularized kernel for any $a > 0$:

$$
I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left( -\frac{\pi^2 u^2}{a} \right)
$$

---

#### Step 5: Limiting Behavior to the Dirac Delta Distribution

To see the physical meaning of $I_a(u)$, define the variance parameter $\sigma^2 = \frac{a}{2\pi^2}$ (so that $\frac{\pi}{a} = \frac{1}{2\sigma^2}$). Then $I_a(u)$ takes the exact form of a **normalized zero-mean Gaussian probability density function**:

$$
I_a(u) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left( -\frac{u^2}{2\sigma^2} \right)
$$

Because a Gaussian probability density integrates to $1$ regardless of its variance $\sigma^2 > 0$, the total area under $I_a(u)$ is locked at $1$ for every $a > 0$:

$$
\int_{-\infty}^{\infty} I_a(u) \, du = 1 \qquad (\forall \, a > 0).
$$

Now take the limit $a \to 0^+$:
- The variance $\sigma^2 = \frac{a}{2\pi^2} \to 0$, so for any nonzero time lag $u \neq 0$, $I_a(u) \to 0$ exponentially fast.
- At zero time lag $u = 0$, the peak height $I_a(0) = \sqrt{\frac{\pi}{a}} \to +\infty$.
- The total area across $u \in (-\infty, \infty)$ remains identically $1$.

A family of smooth functions that concentrates all of its unit mass into an arbitrarily small neighborhood of the origin as $a \to 0^+$ is called a **nascent delta function**, converging in the sense of distributions to the Dirac delta $\delta(u)$:

$$
\lim_{a \to 0^+} I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) \, df = \mathcal{K}(u) = \delta(u) = \delta(t - \tau)
$$

---

#### Step 6: Exact Reconstruction via the Sifting Property

Substituting $\mathcal{K}(t - \tau) = \delta(t - \tau)$ back into our outer time integral from Step 1:

$$
x(t) = \lim_{a \to 0^+} \int_{-\infty}^{\infty} x(\tau) \, I_a(t - \tau) \, d\tau = \int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau
$$

By the sifting property of the Dirac delta distribution (which plucks out the value of $x(\tau)$ at the single point where $t - \tau = 0$, i.e., $\tau = t$):

$$
\int_{-\infty}^{\infty} x(\tau) \, \delta(t - \tau) \, d\tau = x(t) \qquad \blacksquare
$$

</details>

---

### 1.5 Deep Dive & Interactive Zoom Visualization: How $\int_{-\infty}^{\infty} f(x)\,\delta(x - x_0)\,dx = f(x_0)$ Actually Works
<a id="1-5-sifting-property-zoom"></a>

In Step 6 above (and throughout Section 2 below), everything rests on the **sifting property** of the Dirac delta distribution:

$$
\boxed{
\int_{-\infty}^{\infty} f(x) \, \delta(x - x_0) \, dx = f(x_0)
}
$$

At first glance, this equation can feel paradoxical: **If $\delta(x - x_0)$ shoots to $+\infty$ at $x = x_0$ and is zero everywhere else, why doesn't multiplying $f(x)$ by $\infty$ blow up the integral? How does the area under the curve end up equaling the finite number $f(x_0)$?**

We can make this 100% transparent by looking at the nascent Gaussian approximation $\delta_\sigma(x - x_0) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-(x - x_0)^2 / (2\sigma^2)}$ as $\sigma \to 0^+$ and **zooming in around $x = x_0$**:

1. **The Spike Goes to $\infty$, But Its Area Is Locked at $1$:**  
   At $x = x_0$, the peak height of $\delta_\sigma(x - x_0)$ is $\frac{1}{\sqrt{2\pi}\,\sigma}$, which grows toward $+\infty$ as $\sigma \to 0^+$. However, nearly all of its mass is confined within a tiny window $[x_0 - 3\sigma, x_0 + 3\sigma]$ of width $\propto \sigma \to 0$. Height $\propto \frac{1}{\sigma}$ times width $\propto \sigma$ keeps the total area under $\delta_\sigma(x - x_0)$ identically equal to **$1$** for every $\sigma > 0$:

   $$
   \int_{-\infty}^{\infty} \delta_\sigma(x - x_0) \, dx = 1.
   $$

2. **Zoom In Around $x_0$: The Curvy Function $f(x)$ Becomes a Flat Constant Line $f(x_0)$!**  
   Outside the tiny interval $[x_0 - 3\sigma, x_0 + 3\sigma]$, $\delta_\sigma(x - x_0) \approx 0$, so all variations of $f(x)$ away from $x_0$ are multiplied by zero and wiped out.  
   Now **zoom in horizontally** to the microscopic neighborhood $[x_0 - 3\sigma, x_0 + 3\sigma]$ where the spike lives: because $f(x)$ is continuous at $x_0$, **any smooth curve looks completely flat—like the horizontal constant line $y = f(x_0)$—when you zoom in close enough!**  
   Inside that narrow window, multiplying the curve $f(x)$ by the spike $\delta_\sigma(x - x_0)$ is indistinguishable from multiplying the **constant number $f(x_0)$** by $\delta_\sigma(x - x_0)$:

   $$
   f(x) \, \delta_\sigma(x - x_0) \;\approx\; f(x_0) \, \delta_\sigma(x - x_0) \qquad \text{for } |x - x_0| \lesssim 3\sigma.
   $$

3. **Constant $f(x_0)$ Times Unit Area $1$ Equals $f(x_0)$:**  
   Because $f(x_0)$ is just a constant number, it pulls straight out in front of the integral! The remaining integral is simply the unit area ($= 1$) of the delta pulse:

   $$
   \int_{-\infty}^{\infty} f(x) \, \delta_\sigma(x - x_0) \, dx \;\approx\; \int_{-\infty}^{\infty} \underbrace{f(x_0)}_{\text{Constant}} \delta_\sigma(x - x_0) \, dx \;=\; f(x_0) \underbrace{\int_{-\infty}^{\infty} \delta_\sigma(x - x_0) \, dx}_{\text{Area } = \; 1} \;=\; f(x_0) \times 1 \;=\; f(x_0).
   $$

   In the limit $\sigma \to 0^+$, the approximation becomes exact! Even though the peak height of the product curve $f(x)\,\delta_\sigma(x - x_0)$ climbs to $f(x_0) \cdot \frac{1}{\sqrt{2\pi}\sigma} \to \infty$, **the shaded area under the product curve is simply $f(x_0) \times 1 = f(x_0)$**.

<div class="sifting-widget" id="siftingWidget">
  <div class="sifting-widget-header">
    <div>
      <h4 class="sifting-widget-title">🔬 Interactive Zoom Explorer: How $\int f(x)\,\delta_\sigma(x - x_0)\,dx \to f(x_0) \times 1 = f(x_0)$</h4>
      <div class="sifting-widget-subtitle">Zoom in around $x_0$ (via slider, buttons, or mouse scroll wheel on Left Graph) and shrink $\sigma \to 0$ to watch $f(x)$ flatten into constant $f(x_0)$.</div>
    </div>
    <div class="sifting-zoom-presets">
      <button type="button" class="zoom-preset-btn active" data-zoom="1" data-sigma="0.28">1× Macro View</button>
      <button type="button" class="zoom-preset-btn" data-zoom="5" data-sigma="0.14">5× Zoom In</button>
      <button type="button" class="zoom-preset-btn" data-zoom="15" data-sigma="0.06">15× Micro Zoom</button>
      <button type="button" class="zoom-preset-btn" data-zoom="30" data-sigma="0.02">30× Extreme (σ → 0)</button>
    </div>
  </div>

  <div class="sifting-controls-grid">
    <div class="sifting-control-group">
      <div class="sifting-control-label">
        <span>1. Zoom In Around $x_0$</span>
        <span class="sifting-control-val" id="zoomValLabel">1.0×</span>
      </div>
      <input type="range" class="sifting-slider" id="zoomSlider" min="1" max="30" step="0.2" value="1">
      <div class="sifting-control-hint">Zoom into $[x_0 - \Delta x, x_0 + \Delta x]$ to see $f(x)$ flatten into $f(x_0)$</div>
    </div>

    <div class="sifting-control-group">
      <div class="sifting-control-label">
        <span>2. Impulse Width $\sigma$ ($\delta_\sigma \to \delta$)</span>
        <span class="sifting-control-val" id="sigmaValLabel">σ = 0.280</span>
      </div>
      <input type="range" class="sifting-slider" id="sigmaSlider" min="0.015" max="0.45" step="0.005" value="0.28">
      <div class="sifting-control-hint">Drag left ($\sigma \to 0$): peak $\to \infty$, width $\to 0$, area stays $1$</div>
    </div>

    <div class="sifting-control-group">
      <div class="sifting-control-label">
        <span>3. Sifting Point $x_0$</span>
        <span class="sifting-control-val" id="x0ValLabel">x₀ = 0.60</span>
      </div>
      <input type="range" class="sifting-slider" id="x0Slider" min="-2.2" max="2.2" step="0.02" value="0.60">
      <div class="sifting-control-hint">Slide $x_0$ to sift out $f(x_0)$ at any position along $f(x)$</div>
    </div>
  </div>

  <div class="sifting-canvases-grid">
    <div class="sifting-canvas-card">
      <div class="sifting-canvas-title">
        <span>A. Zoomable View Around $x_0$ (Scroll to Zoom · Drag to Move $x_0$)</span>
        <span class="badge" id="windowRangeBadge">Window: [−3.0, +3.0]</span>
      </div>
      <div class="sifting-canvas-wrap">
        <canvas id="siftingMacroCanvas"></canvas>
      </div>
    </div>

    <div class="sifting-canvas-card">
      <div class="sifting-canvas-title">
        <span>B. Auto-Rescaled Spike Inspector on $[x_0 - 3.5\sigma, x_0 + 3.5\sigma]$</span>
        <span class="badge" id="peakHeightBadge">Peak: 1.42</span>
      </div>
      <div class="sifting-canvas-wrap">
        <canvas id="siftingMicroCanvas"></canvas>
      </div>
    </div>
  </div>

  <div class="sifting-readout-bar">
    <div class="sifting-metric-card">
      <div class="sifting-metric-label">Impulse Peak $\delta_\sigma(0)$</div>
      <div class="sifting-metric-value" id="metricPeakVal">1.42 → ∞</div>
    </div>
    <div class="sifting-metric-card">
      <div class="sifting-metric-label">Unit Area $\int \delta_\sigma(x-x_0)\,dx$</div>
      <div class="sifting-metric-value" id="metricDeltaArea">1.0000</div>
    </div>
    <div class="sifting-metric-card">
      <div class="sifting-metric-label">Constant $f(x_0) \times 1$</div>
      <div class="sifting-metric-value" id="metricFx0Val">2.1840</div>
    </div>
    <div class="sifting-metric-card highlight-emerald">
      <div class="sifting-metric-label">Shaded Area $\int f(x)\delta_\sigma\,dx$</div>
      <div class="sifting-metric-value" id="metricProductArea">2.1492</div>
    </div>
  </div>

  <div class="sifting-legend">
    <span class="sifting-legend-item"><span class="legend-swatch" style="background: #2563eb;"></span> Signal $f(x)$</span>
    <span class="sifting-legend-item"><span class="legend-swatch" style="background: #f59e0b;"></span> Constant Line $y = f(x_0)$ &amp; Ideal $f(x_0)\,\delta_\sigma(x-x_0)$</span>
    <span class="sifting-legend-item"><span class="legend-swatch" style="background: #8b5cf6;"></span> Unit Impulse $\delta_\sigma(x-x_0)$ (Area $= 1$)</span>
    <span class="sifting-legend-item"><span class="legend-swatch" style="background: #10b981; height: 8px;"></span> Shaded Product $f(x)\,\delta_\sigma(x-x_0)$ (Area $\to f(x_0) \times 1$)</span>
  </div>
</div>

<script>
(function() {
  function initSiftingExplorer() {
    var macroCanvas = document.getElementById('siftingMacroCanvas');
    var microCanvas = document.getElementById('siftingMicroCanvas');
    if (!macroCanvas || !microCanvas) return;

    var zoomSlider = document.getElementById('zoomSlider');
    var sigmaSlider = document.getElementById('sigmaSlider');
    var x0Slider = document.getElementById('x0Slider');
    var presetBtns = document.querySelectorAll('.zoom-preset-btn');

    var zoomValLabel = document.getElementById('zoomValLabel');
    var sigmaValLabel = document.getElementById('sigmaValLabel');
    var x0ValLabel = document.getElementById('x0ValLabel');
    var windowRangeBadge = document.getElementById('windowRangeBadge');
    var peakHeightBadge = document.getElementById('peakHeightBadge');

    var metricPeakVal = document.getElementById('metricPeakVal');
    var metricDeltaArea = document.getElementById('metricDeltaArea');
    var metricFx0Val = document.getElementById('metricFx0Val');
    var metricProductArea = document.getElementById('metricProductArea');

    // Smooth test signal f(x) (positive, realistic multi-frequency wave)
    function fSignal(x) {
      return 1.65 + 0.65 * Math.sin(1.35 * x) + 0.32 * Math.cos(2.7 * x - 0.4);
    }

    // Nascent Gaussian delta_sigma(x - x0)
    function deltaSigma(x, x0, sigma) {
      var u = (x - x0) / sigma;
      return Math.exp(-0.5 * u * u) / (Math.sqrt(2 * Math.PI) * sigma);
    }

    // High-accuracy numerical quadrature over [x0 - 6*sigma, x0 + 6*sigma]
    function computeIntegral(x0, sigma) {
      var N = 400;
      var a = x0 - 6 * sigma;
      var b = x0 + 6 * sigma;
      var h = (b - a) / N;
      var sum = 0.5 * (fSignal(a) * deltaSigma(a, x0, sigma) + fSignal(b) * deltaSigma(b, x0, sigma));
      for (var i = 1; i < N; i++) {
        var x = a + i * h;
        sum += fSignal(x) * deltaSigma(x, x0, sigma);
      }
      return sum * h;
    }

    function getThemeColors() {
      var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
      return {
        bg: isDark ? '#0b111e' : '#ffffff',
        grid: isDark ? 'rgba(148, 163, 184, 0.14)' : 'rgba(100, 116, 139, 0.14)',
        axis: isDark ? '#64748b' : '#475569',
        text: isDark ? '#cbd5e1' : '#334155',
        muted: isDark ? '#94a3b8' : '#64748b',
        blue: isDark ? '#60a5fa' : '#2563eb',
        amber: isDark ? '#fbbf24' : '#d97706',
        purple: isDark ? '#a78bfa' : '#7c3aed',
        emerald: isDark ? '#34d399' : '#059669',
        emeraldFill: isDark ? 'rgba(16, 185, 129, 0.28)' : 'rgba(16, 185, 129, 0.22)',
        purpleFill: isDark ? 'rgba(139, 92, 246, 0.12)' : 'rgba(124, 58, 237, 0.09)'
      };
    }

    function setupCanvas(canvas) {
      var rect = canvas.parentElement.getBoundingClientRect();
      var dpr = window.devicePixelRatio || 1;
      canvas.width = Math.max(260, Math.floor(rect.width * dpr));
      canvas.height = Math.max(200, Math.floor(rect.height * dpr));
      var ctx = canvas.getContext('2d');
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      return { ctx: ctx, w: rect.width, h: rect.height };
    }

    function render() {
      var zoom = parseFloat(zoomSlider.value);
      var sigma = parseFloat(sigmaSlider.value);
      var x0 = parseFloat(x0Slider.value);

      var fx0 = fSignal(x0);
      var deltaPeak = 1 / (Math.sqrt(2 * Math.PI) * sigma);
      var prodPeak = fx0 * deltaPeak;
      var exactArea = computeIntegral(x0, sigma);

      // Update labels & readouts
      zoomValLabel.textContent = zoom.toFixed(1) + '×';
      sigmaValLabel.textContent = 'σ = ' + sigma.toFixed(3);
      x0ValLabel.textContent = 'x₀ = ' + x0.toFixed(2);

      var halfSpan = 3.0 / zoom;
      var xMin = ( zoom <= 1.05 ) ? -3.0 : (x0 - halfSpan);
      var xMax = ( zoom <= 1.05 ) ?  3.0 : (x0 + halfSpan);
      windowRangeBadge.textContent = 'Window: [' + xMin.toFixed(2) + ', ' + xMax.toFixed(2) + ']';
      peakHeightBadge.textContent = 'f(x₀)·δ_σ Peak: ' + prodPeak.toFixed(1);

      metricPeakVal.textContent = deltaPeak.toFixed(2);
      metricDeltaArea.textContent = '1.0000';
      metricFx0Val.textContent = fx0.toFixed(4);
      metricProductArea.textContent = exactArea.toFixed(4);

      var colors = getThemeColors();

      // =====================================================================
      // 1. Draw Left Canvas (Macro / Zoomable View)
      // =====================================================================
      var m1 = setupCanvas(macroCanvas);
      var ctx1 = m1.ctx, w1 = m1.w, h1 = m1.h;
      var padL = 42, padR = 16, padT = 20, padB = 30;
      var pw1 = w1 - padL - padR;
      var ph1 = h1 - padT - padB;

      ctx1.fillStyle = colors.bg;
      ctx1.fillRect(0, 0, w1, h1);

      // Dynamic yMax on macro canvas so user sees spike shooting upward
      var yMax1 = Math.min(18, Math.max(4.2, Math.min(prodPeak * 1.12, 4.2 + (zoom - 1) * 0.45)));
      function toX1(x) { return padL + ((x - xMin) / (xMax - xMin)) * pw1; }
      function toY1(y) { return padT + ph1 - (y / yMax1) * ph1; }

      // Grid lines
      ctx1.strokeStyle = colors.grid;
      ctx1.lineWidth = 1;
      var yStep1 = yMax1 > 8 ? 2 : 1;
      for (var yv = 0; yv <= yMax1; yv += yStep1) {
        var py = toY1(yv);
        ctx1.beginPath();
        ctx1.moveTo(padL, py);
        ctx1.lineTo(w1 - padR, py);
        ctx1.stroke();

        ctx1.fillStyle = colors.muted;
        ctx1.font = '10px Inter, sans-serif';
        ctx1.textAlign = 'right';
        ctx1.fillText(yv.toFixed(0), padL - 6, py + 3);
      }

      // X-axis ticks
      var numXTicks = 5;
      for (var ti = 0; ti <= numXTicks; ti++) {
        var xv = xMin + (ti / numXTicks) * (xMax - xMin);
        var px = toX1(xv);
        ctx1.beginPath();
        ctx1.moveTo(px, padT);
        ctx1.lineTo(px, padT + ph1);
        ctx1.stroke();

        ctx1.fillStyle = colors.muted;
        ctx1.font = '10px Inter, sans-serif';
        ctx1.textAlign = 'center';
        ctx1.fillText(xv.toFixed(2), px, h1 - 9);
      }

      // Axes border
      ctx1.strokeStyle = colors.axis;
      ctx1.lineWidth = 1.3;
      ctx1.beginPath();
      ctx1.moveTo(padL, padT);
      ctx1.lineTo(padL, padT + ph1);
      ctx1.lineTo(w1 - padR, padT + ph1);
      ctx1.stroke();

      // Clip to plot area for curves
      ctx1.save();
      ctx1.beginPath();
      ctx1.rect(padL, padT, pw1, ph1);
      ctx1.clip();

      var steps = 320;

      // (a) Shaded unit impulse delta_sigma(x - x0) (purple dashed)
      ctx1.beginPath();
      ctx1.moveTo(toX1(xMin), toY1(0));
      for (var i = 0; i <= steps; i++) {
        var xx = xMin + (i / steps) * (xMax - xMin);
        ctx1.lineTo(toX1(xx), toY1(deltaSigma(xx, x0, sigma)));
      }
      ctx1.lineTo(toX1(xMax), toY1(0));
      ctx1.closePath();
      ctx1.fillStyle = colors.purpleFill;
      ctx1.fill();

      ctx1.beginPath();
      ctx1.setLineDash([4, 3]);
      for (var i = 0; i <= steps; i++) {
        var xx = xMin + (i / steps) * (xMax - xMin);
        var yy = toY1(deltaSigma(xx, x0, sigma));
        if (i === 0) ctx1.moveTo(toX1(xx), yy);
        else ctx1.lineTo(toX1(xx), yy);
      }
      ctx1.strokeStyle = colors.purple;
      ctx1.lineWidth = 1.6;
      ctx1.stroke();
      ctx1.setLineDash([]);

      // (b) Shaded Product f(x) * delta_sigma(x - x0) (emerald fill + solid stroke)
      ctx1.beginPath();
      ctx1.moveTo(toX1(xMin), toY1(0));
      for (var i = 0; i <= steps; i++) {
        var xx = xMin + (i / steps) * (xMax - xMin);
        var prodY = fSignal(xx) * deltaSigma(xx, x0, sigma);
        ctx1.lineTo(toX1(xx), toY1(prodY));
      }
      ctx1.lineTo(toX1(xMax), toY1(0));
      ctx1.closePath();
      ctx1.fillStyle = colors.emeraldFill;
      ctx1.fill();

      ctx1.beginPath();
      for (var i = 0; i <= steps; i++) {
        var xx = xMin + (i / steps) * (xMax - xMin);
        var prodY = fSignal(xx) * deltaSigma(xx, x0, sigma);
        if (i === 0) ctx1.moveTo(toX1(xx), toY1(prodY));
        else ctx1.lineTo(toX1(xx), toY1(prodY));
      }
      ctx1.strokeStyle = colors.emerald;
      ctx1.lineWidth = 2.2;
      ctx1.stroke();

      // (c) Horizontal Constant Line y = f(x0) (amber dashed)
      var yFx0Px = toY1(fx0);
      ctx1.beginPath();
      ctx1.setLineDash([6, 4]);
      ctx1.moveTo(padL, yFx0Px);
      ctx1.lineTo(w1 - padR, yFx0Px);
      ctx1.strokeStyle = colors.amber;
      ctx1.lineWidth = 1.8;
      ctx1.stroke();
      ctx1.setLineDash([]);

      // (d) Continuous Signal f(x) (blue solid)
      ctx1.beginPath();
      for (var i = 0; i <= steps; i++) {
        var xx = xMin + (i / steps) * (xMax - xMin);
        var yy = toY1(fSignal(xx));
        if (i === 0) ctx1.moveTo(toX1(xx), yy);
        else ctx1.lineTo(toX1(xx), yy);
      }
      ctx1.strokeStyle = colors.blue;
      ctx1.lineWidth = 2.5;
      ctx1.stroke();

      // Vertical marker at x = x0 and dot at (x0, f(x0))
      var px0 = toX1(x0);
      ctx1.beginPath();
      ctx1.setLineDash([3, 3]);
      ctx1.moveTo(px0, padT);
      ctx1.lineTo(px0, padT + ph1);
      ctx1.strokeStyle = colors.amber;
      ctx1.lineWidth = 1.2;
      ctx1.stroke();
      ctx1.setLineDash([]);

      ctx1.beginPath();
      ctx1.arc(px0, yFx0Px, 5, 0, 2 * Math.PI);
      ctx1.fillStyle = colors.amber;
      ctx1.fill();

      // If spike exceeds yMax1, draw upward arrow indicator at top of spike
      if (prodPeak > yMax1) {
        ctx1.fillStyle = colors.emerald;
        ctx1.font = 'bold 10.5px Inter, sans-serif';
        ctx1.textAlign = 'center';
        ctx1.fillText('↑ Peak = ' + prodPeak.toFixed(1) + ' (See Panel B)', Math.min(w1 - 85, Math.max(padL + 85, px0)), padT + 14);
      }

      // Label f(x0)
      ctx1.fillStyle = colors.amber;
      ctx1.font = 'bold 11px Inter, sans-serif';
      ctx1.textAlign = 'left';
      ctx1.fillText('f(x₀) = ' + fx0.toFixed(2), padL + 8, Math.max(padT + 14, yFx0Px - 6));

      ctx1.restore();

      // =====================================================================
      // 2. Draw Right Canvas (Auto-Rescaled Microscopic Spike Inspector)
      // =====================================================================
      var m2 = setupCanvas(microCanvas);
      var ctx2 = m2.ctx, w2 = m2.w, h2 = m2.h;
      var padL2 = 44, padR2 = 14, padT2 = 22, padB2 = 30;
      var pw2 = w2 - padL2 - padR2;
      var ph2 = h2 - padT2 - padB2;

      ctx2.fillStyle = colors.bg;
      ctx2.fillRect(0, 0, w2, h2);

      var xMin2 = x0 - 3.5 * sigma;
      var xMax2 = x0 + 3.5 * sigma;
      var yMax2 = Math.max(deltaPeak, prodPeak) * 1.15;

      function toX2(x) { return padL2 + ((x - xMin2) / (xMax2 - xMin2)) * pw2; }
      function toY2(y) { return padT2 + ph2 - (y / yMax2) * ph2; }

      // Grid lines
      ctx2.strokeStyle = colors.grid;
      ctx2.lineWidth = 1;
      for (var gi = 0; gi <= 4; gi++) {
        var yv2 = (gi / 4) * yMax2;
        var py2 = toY2(yv2);
        ctx2.beginPath();
        ctx2.moveTo(padL2, py2);
        ctx2.lineTo(w2 - padR2, py2);
        ctx2.stroke();

        ctx2.fillStyle = colors.muted;
        ctx2.font = '10px Inter, sans-serif';
        ctx2.textAlign = 'right';
        ctx2.fillText(yv2 >= 10 ? yv2.toFixed(0) : yv2.toFixed(1), padL2 - 5, py2 + 3);
      }

      // X ticks at x0 - 2*sigma, x0, x0 + 2*sigma
      var xTicks2 = [
        { val: x0 - 2 * sigma, label: 'x₀−2σ' },
        { val: x0,             label: 'x₀ (' + x0.toFixed(2) + ')' },
        { val: x0 + 2 * sigma, label: 'x₀+2σ' }
      ];
      xTicks2.forEach(function(tk) {
        var px2 = toX2(tk.val);
        ctx2.beginPath();
        ctx2.moveTo(px2, padT2);
        ctx2.lineTo(px2, padT2 + ph2);
        ctx2.strokeStyle = colors.grid;
        ctx2.stroke();

        ctx2.fillStyle = colors.muted;
        ctx2.font = '10px Inter, sans-serif';
        ctx2.textAlign = 'center';
        ctx2.fillText(tk.label, px2, h2 - 9);
      });

      // Axes border
      ctx2.strokeStyle = colors.axis;
      ctx2.lineWidth = 1.3;
      ctx2.beginPath();
      ctx2.moveTo(padL2, padT2);
      ctx2.lineTo(padL2, padT2 + ph2);
      ctx2.lineTo(w2 - padR2, padT2 + ph2);
      ctx2.stroke();

      ctx2.save();
      ctx2.beginPath();
      ctx2.rect(padL2, padT2, pw2, ph2);
      ctx2.clip();

      // (a) Unit impulse delta_sigma(x - x0) (purple dashed, Area = 1)
      ctx2.beginPath();
      ctx2.setLineDash([4, 3]);
      for (var i = 0; i <= 200; i++) {
        var xx = xMin2 + (i / 200) * (xMax2 - xMin2);
        var yy = toY2(deltaSigma(xx, x0, sigma));
        if (i === 0) ctx2.moveTo(toX2(xx), yy);
        else ctx2.lineTo(toX2(xx), yy);
      }
      ctx2.strokeStyle = colors.purple;
      ctx2.lineWidth = 1.6;
      ctx2.stroke();
      ctx2.setLineDash([]);

      // (b) True Product f(x) * delta_sigma(x - x0) (emerald shaded)
      ctx2.beginPath();
      ctx2.moveTo(toX2(xMin2), toY2(0));
      for (var i = 0; i <= 200; i++) {
        var xx = xMin2 + (i / 200) * (xMax2 - xMin2);
        ctx2.lineTo(toX2(xx), toY2(fSignal(xx) * deltaSigma(xx, x0, sigma)));
      }
      ctx2.lineTo(toX2(xMax2), toY2(0));
      ctx2.closePath();
      ctx2.fillStyle = colors.emeraldFill;
      ctx2.fill();

      ctx2.beginPath();
      for (var i = 0; i <= 200; i++) {
        var xx = xMin2 + (i / 200) * (xMax2 - xMin2);
        var yy = toY2(fSignal(xx) * deltaSigma(xx, x0, sigma));
        if (i === 0) ctx2.moveTo(toX2(xx), yy);
        else ctx2.lineTo(toX2(xx), yy);
      }
      ctx2.strokeStyle = colors.emerald;
      ctx2.lineWidth = 2.4;
      ctx2.stroke();

      // (c) Ideal Constant-Scaled Impulse f(x0) * delta_sigma(x - x0) (amber dashed overlay)
      ctx2.beginPath();
      ctx2.setLineDash([5, 4]);
      for (var i = 0; i <= 200; i++) {
        var xx = xMin2 + (i / 200) * (xMax2 - xMin2);
        var yy = toY2(fx0 * deltaSigma(xx, x0, sigma));
        if (i === 0) ctx2.moveTo(toX2(xx), yy);
        else ctx2.lineTo(toX2(xx), yy);
      }
      ctx2.strokeStyle = colors.amber;
      ctx2.lineWidth = 2.0;
      ctx2.stroke();
      ctx2.setLineDash([]);

      // Annotation inside Panel B showing Area = f(x0) x 1
      ctx2.fillStyle = colors.emerald;
      ctx2.font = 'bold 11px Inter, sans-serif';
      ctx2.textAlign = 'center';
      ctx2.fillText('Area = ' + exactArea.toFixed(3) + ' ≈ f(x₀) × 1', toX2(x0), padT2 + 15);

      ctx2.restore();
    }

    // Event Listeners
    function clearActivePresets() {
      presetBtns.forEach(function(b) { b.classList.remove('active'); });
    }

    zoomSlider.addEventListener('input', function() { clearActivePresets(); render(); });
    sigmaSlider.addEventListener('input', function() { clearActivePresets(); render(); });
    x0Slider.addEventListener('input', function() { render(); });

    presetBtns.forEach(function(btn) {
      btn.addEventListener('click', function() {
        clearActivePresets();
        btn.classList.add('active');
        zoomSlider.value = btn.getAttribute('data-zoom');
        sigmaSlider.value = btn.getAttribute('data-sigma');
        render();
      });
    });

    // Mouse wheel zoom on Left Canvas
    macroCanvas.addEventListener('wheel', function(e) {
      e.preventDefault();
      clearActivePresets();
      var z = parseFloat(zoomSlider.value);
      var factor = e.deltaY < 0 ? 1.18 : (1 / 1.18);
      var nextZ = Math.min(30, Math.max(1, z * factor));
      zoomSlider.value = nextZ;
      render();
    }, { passive: false });

    // Click / drag on Left Canvas to move x0
    var isDragging = false;
    function updateX0FromPointer(clientX) {
      var rect = macroCanvas.getBoundingClientRect();
      var padL = 42, padR = 16;
      var pw = rect.width - padL - padR;
      var rel = Math.min(1, Math.max(0, (clientX - rect.left - padL) / pw));
      var zoom = parseFloat(zoomSlider.value);
      var x0 = parseFloat(x0Slider.value);
      var halfSpan = 3.0 / zoom;
      var xMin = (zoom <= 1.05) ? -3.0 : (x0 - halfSpan);
      var xMax = (zoom <= 1.05) ?  3.0 : (x0 + halfSpan);
      var newX0 = Math.min(2.2, Math.max(-2.2, xMin + rel * (xMax - xMin)));
      x0Slider.value = newX0;
      render();
    }

    macroCanvas.addEventListener('mousedown', function(e) {
      isDragging = true;
      updateX0FromPointer(e.clientX);
    });
    window.addEventListener('mousemove', function(e) {
      if (isDragging) updateX0FromPointer(e.clientX);
    });
    window.addEventListener('mouseup', function() {
      isDragging = false;
    });

    window.addEventListener('resize', render);

    // Repaint when theme changes
    var observer = new MutationObserver(render);
    observer.observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });

    render();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initSiftingExplorer);
  } else {
    initSiftingExplorer();
  }
})();
</script>

---

## 2. Discrete-Time Fourier Transform (DTFT) & The Mathematics of Sampling
<a id="2-discrete-time-fourier-transform-dtft"></a>

In Part 1, we assumed we knew the continuous voltage $x(t)$ at every real number $t \in \mathbb{R}$. In any real laboratory experiment, however, a computer cannot store an uncountably infinite continuum of time points. Instead, an **Analog-to-Digital Converter (ADC)** measures snapshots of the continuous brain signal at uniform time intervals of duration $T$ seconds:

$$
t_n = nT, \qquad n \in \{\dots, -2, -1, 0, 1, 2, \dots\}
$$

This defines two fundamental sampling rate variables:
- **Linear sampling rate:** $f_s = \frac{1}{T}$ (in $\text{Hz}$, or samples per second). For example, if $T = 1\text{ ms} = 0.001\text{ s}$, then $f_s = 1000\text{ Hz}$.
- **Angular sampling frequency:** $\Omega = 2\pi f_s = \frac{2\pi}{T}$ (in $\text{rad/s}$).

This raises a deep question: **When we throw away everything between the sample times $t = nT$, what happens to the continuous Fourier spectrum $X(\omega)$ of our signal? When can we still recover the true brain signal, and when do high frequencies corrupt our recording?**

---

### 2.1 Ideal Impulse-Train Sampling: Why Multiply by a Dirac Comb?

If we immediately discard continuous time $t$ and write our recorded data as a discrete list of numbers $x[n] = x(nT)$, we sever the mathematical link to the Continuous-Time Fourier Transform integral. How can we keep the sampled signal *inside* the continuous-time world so we can directly compare its spectrum to the original analog spectrum $X(\omega)$?

The key mathematical insight is to model digital sampling as multiplying our continuous signal $x(t)$ by a periodic **Dirac delta train** (also called a **Dirac comb** or **Shah distribution**) $s(t)$ of period $T$:

$$
s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT)
$$

Multiplying the continuous signal $x(t)$ by the sampling comb $s(t)$ produces the **impulse-sampled continuous-time signal** $x_s(t)$:

$$
x_s(t) = x(t) \cdot s(t) = x(t) \sum_{n=-\infty}^{\infty} \delta(t - nT)
$$

Because each impulse $\delta(t - nT)$ is zero everywhere except at the exact instant $t = nT$, multiplying a continuous function $x(t)$ by $\delta(t - nT)$ simply scales that impulse by the snapshot value $x(nT)$, i.e., $x(t)\delta(t - nT) = x(nT)\delta(t - nT)$. Thus:

$$
x_s(t) = \sum_{n=-\infty}^{\infty} x(nT) \, \delta(t - nT)
$$

<div class="intuition-box" markdown="1">
<div class="callout-header">💡 Physical Intuition: The Strobe-Light Bridge</div>

Think of $s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT)$ as an ideal **stroboscope** that flashes an infinitely brief, unit-energy pulse of light every $T$ seconds in a dark room:
- Between flashes ($t \neq nT$), $x_s(t) = 0$.
- At each flash ($t = nT$), the impulse $\delta(t - nT)$ records the exact instantaneous height $x(nT)$ of the continuous wave as its impulse weight (area).
- Because $x_s(t)$ is still a generalized function of continuous time $t \in \mathbb{R}$, we can feed $x_s(t)$ directly into the Continuous-Time Fourier Transform!
</div>

---

### 2.2 Deriving the DTFT from the Sampled Signal

Let us now compute the Continuous-Time Fourier Transform (using the non-unitary signal processing angular frequency convention $\omega$) of our impulse-sampled signal $x_s(t)$:

$$
X_s(\omega) = \int_{-\infty}^{\infty} x_s(t) e^{-i\omega t} \, dt = \int_{-\infty}^{\infty} \left( \sum_{n=-\infty}^{\infty} x(nT) \, \delta(t - nT) \right) e^{-i\omega t} \, dt
$$

Interchanging the summation and integration:

$$
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) \int_{-\infty}^{\infty} \delta(t - nT) e^{-i\omega t} \, dt
$$

By the sifting property of the Dirac delta ($\int_{-\infty}^{\infty} \delta(t - nT) e^{-i\omega t} \, dt = e^{-inT\omega}$), the continuous integral collapses into a discrete sum over the sample indices $n$—giving birth to the **Discrete-Time Fourier Transform (DTFT)**:

$$
\boxed{
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) e^{-inT\omega}
}
$$

*(Note on DSP Notation: Many digital signal processing textbooks define the dimensionless normalized frequency $\hat{\omega} = \omega T$ in $\text{radians/sample}$ and write $X(e^{i\hat{\omega}}) = \sum_{n=-\infty}^{\infty} x[n] e^{-i\hat{\omega} n}$. That is the exact same formula! Keeping $\omega$ in physical $\text{rad/s}$ and $T$ explicit here allows us to see directly how changing the physical sampling interval $T$ alters the frequency spectrum).*

#### Connecting the Sampled Spectrum $X_s(\omega)$ Back to the True Analog Spectrum $X(\omega)$

How does the DTFT $X_s(\omega)$ relate to the true continuous-time Fourier transform $X(\omega)$ of the underlying analog brain signal $x(t)$?

At each sample instant $t = nT$, the sample value $x(nT)$ can be written in terms of the true continuous spectrum $X(\theta)$ via the inverse CTFT:

$$
x(nT) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) e^{inT\theta} \, d\theta
$$

Substitute this expression for $x(nT)$ directly into our DTFT formula above:

$$
\begin{aligned}
X_s(\omega) 
&= \sum_{n=-\infty}^{\infty} \left( \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) e^{inT\theta} \, d\theta \right) e^{-inT\omega} \\
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \underbrace{\left( \sum_{n=-\infty}^{\infty} e^{-inT(\omega - \theta)} \right)}_{\text{Infinite Harmonic Sum}} d\theta
\end{aligned}
$$

Look closely at the bracketed term inside the integral: the true analog spectrum $X(\theta)$ is being convolved against the infinite harmonic sum $\sum_{n=-\infty}^{\infty} e^{-inT(\omega - \theta)}$. Everything about digital sampling—periodicity, the Nyquist limit, and aliasing—hinges on what this infinite sum of rotating complex exponentials equals!

---

### 2.3 The Crucial Distributional Identity
<a id="2-the-crucial-identity"></a>

We now examine the foundational identity that governs periodic harmonic sums in the sense of generalized functions (tempered distributions, $\mathcal{S}'(\mathbb{R})$):

$$
\boxed{
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

<div class="math-highlight-box" markdown="1">
<div class="callout-header">✨ The Deep Symmetry: A Comb in Time Is a Comb in Frequency</div>

Notice what the left-hand side actually is: because $\int_{-\infty}^{\infty} \delta(t - nT) e^{-i\omega t}\,dt = e^{-inT\omega}$, the sum $\sum_{n=-\infty}^{\infty} e^{-inT\omega}$ is the **Continuous-Time Fourier Transform of the time-domain Dirac comb** $s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT)$!

This identity reveals a remarkable duality of nature:
- **In Time:** A periodic train of impulses spaced by **$T$ seconds**.
- **In Frequency:** A periodic train of impulses spaced by **$\Omega = \frac{2\pi}{T}\text{ rad/s}$** (or $f_s = \frac{1}{T}\text{ Hz}$).
- **Reciprocal Scaling (Uncertainty Principle):** If you sample **faster** in time (smaller $T$, impulses packed closer together), the frequency impulses move **further apart** (larger $\frac{2\pi}{T}$), giving your spectrum more room before copies collide! Conversely, if you sample **slowly** (larger $T$), the frequency impulses crowd together.
</div>

Let us dissect **why** this identity holds through four intuitive steps.

---

#### 1. Why Discrete Time Forces Periodicity in Frequency

Why is the spectrum of any discretely sampled signal periodic in $\omega$ with period $\Omega = \frac{2\pi}{T}$? Shift the angular frequency $\omega$ by $\frac{2\pi}{T}$:

$$
\begin{aligned}
e^{-inT\left(\omega + \frac{2\pi}{T}\right)}
&= e^{-inT\omega} \, e^{-i 2\pi n} \\
&= e^{-inT\omega}.
\end{aligned}
$$

Because the sample index $n$ is strictly an **integer** ($n \in \mathbb{Z}$), shifting frequency by $\frac{2\pi}{T}$ adds a phase of $-2\pi n$ radians—which is an **exact integer number of full $360^\circ$ turns** on the complex unit circle ($e^{-i 2\pi n} = \cos(2\pi n) - i\sin(2\pi n) = 1$)!

**Physical meaning:** If you only observe a spinning wheel once every $T$ seconds, a wheel spinning at $\omega$ and a wheel spinning at $\omega + \frac{2\pi}{T}$ (one extra full revolution per sample interval $T$) land at the **exact same angle at every single flash $t = nT$**. Therefore, the infinite sum is strictly periodic with period $\Omega = \frac{2\pi}{T}$:

$$
\sum_{n=-\infty}^{\infty} e^{-inT\left(\omega + \frac{2\pi}{T}\right)} = \sum_{n=-\infty}^{\infty} e^{-inT\omega}.
$$

---

#### 2. Constructive vs. Destructive Interference of Phasors

Think of each term $e^{-inT\omega}$ for $n = \dots, -2, -1, 0, 1, 2, \dots$ as a unit arrow of length $1$ on the complex plane pointing at angle $\theta_n = -nT\omega$:

- **At integer multiples of the sampling frequency $\left(\omega = \frac{2\pi k}{T}, \; k \in \mathbb{Z}\right)$:**  
  Every single term in the infinite series evaluates to:

  $$
  e^{-inT(2\pi k/T)} = e^{-i 2\pi n k} = 1.
  $$

  Every unit arrow points straight along the positive real axis ($+1 + 0i$)! The terms add in **perfect constructive phase**, exploding to infinity as the number of terms grows and forming a Dirac impulse at each harmonic $\omega_k = \frac{2\pi k}{T}$.

- **Between the harmonics $\left(\omega \neq \frac{2\pi k}{T}\right)$:**  
  Each step $n \to n+1$ rotates the unit arrow by a non-trivial angle $-T\omega \not\equiv 0 \pmod{2\pi}$. As $n$ runs from $-\infty$ to $\infty$, the arrows fan out around the unit circle. While the infinite sum does not converge pointwise to zero, its rapid phase oscillations remain bounded and **cancel destructively** whenever integrated against any smooth, rapidly decaying test function $\phi(\omega) \in \mathcal{S}(\mathbb{R})$.

---

#### 3. Exact Finite-Sum Analysis: The Dirichlet Kernel $S_N(\omega)$

To watch the Dirac impulses emerge before our eyes, let us truncate the infinite series to a symmetric finite sum of $2N+1$ terms ($n = -N, \dots, N$):

$$
S_N(\omega) = \sum_{n=-N}^{N} e^{-inT\omega} = 1 + 2\sum_{n=1}^{N} \cos(nT\omega).
$$

We can collapse this sum of $2N+1$ waves into a single closed-form expression using a beautiful **telescoping trick**: multiply $S_N(\omega)$ by $e^{i\frac{1}{2}T\omega} - e^{-i\frac{1}{2}T\omega} = 2i\sin\left(\frac{1}{2}T\omega\right)$:

$$
\begin{aligned}
\left(e^{i\frac{1}{2}T\omega} - e^{-i\frac{1}{2}T\omega}\right) S_N(\omega)
&= \sum_{n=-N}^{N} \left( e^{-i\left(n - \frac{1}{2}\right)T\omega} - e^{-i\left(n + \frac{1}{2}\right)T\omega} \right) \\
&= e^{i\left(N + \frac{1}{2}\right)T\omega} - e^{-i\left(N + \frac{1}{2}\right)T\omega} \\
&= 2i \sin\left(\left(N + \frac{1}{2}\right)T\omega\right),
\end{aligned}
$$

where every interior term cancels with its neighbor! Dividing both sides by $2i\sin\left(\frac{1}{2}T\omega\right)$ yields the famous **Dirichlet kernel**:

$$
\boxed{
S_N(\omega) = \frac{\sin\left(\left(N + \frac{1}{2}\right) T\omega\right)}{\sin\left(\frac{1}{2} T\omega\right)}
}
$$

Let us track the geometry of $S_N(\omega)$ as the number of samples grows ($N \to \infty$):

- **Peak height grows linearly with $N$:** At each harmonic $\omega_k = \frac{2\pi k}{T}$, both numerator and denominator approach zero, and by continuity (or L'Hôpital's rule, since all $2N+1$ terms equal $1$):

  $$
  S_N(\omega_k) = 2N + 1 \xrightarrow{N \to \infty} \infty.
  $$

- **Main-lobe width shrinks as $\frac{1}{N}$:** Around $\omega = 0$, the numerator $\sin\left(\left(N+\frac{1}{2}\right)T\omega\right)$ hits its first zeros when $\left(N+\frac{1}{2}\right)T\omega = \pm \pi$, i.e., at:

  $$
  \omega = \pm\frac{2\pi}{(2N+1)T} \implies \text{Main-lobe width } \Delta\omega = \frac{4\pi}{(2N+1)T} \xrightarrow{N \to \infty} 0.
  $$

- **Distributional cancellation of the side lobes:** Away from $\omega_k = \frac{2\pi k}{T}$, the denominator $\sin\left(\frac{1}{2}T\omega\right)$ is nonzero and smooth, while the numerator $\sin\left(\left(N+\frac{1}{2}\right)T\omega\right)$ oscillates at an arbitrarily high frequency as $N \to \infty$. By the **Riemann–Lebesgue Lemma**, when $S_N(\omega)$ is integrated against any smooth test function $\phi(\omega)$, the rapidly alternating positive and negative side lobes cancel to zero!

<figure class="diagram-figure">
<svg viewBox="0 0 820 290" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Phasor alignment on the unit circle and the finite-sum Dirichlet kernel S_N(omega) sharpening into the periodic Dirac comb.">
  <!-- Left Panel: Phasor Clock Intuition -->
  <rect x="12" y="12" width="295" height="266" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="160" y="35" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">1. Phasor Clock e⁻ⁱⁿᵀω on Unit Circle</text>
  <text x="160" y="51" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Why spikes form only at ω = 2πk/T</text>

  <!-- Sub-circle Top: Constructive (omega = 2pi k / T) -->
  <circle cx="82" cy="118" r="42" fill="none" stroke="var(--border-strong)" stroke-width="1.3" stroke-dasharray="3,3"/>
  <line x1="32" y1="118" x2="134" y2="118" stroke="var(--border-strong)" stroke-width="1"/>
  <line x1="82" y1="68" x2="82" y2="168" stroke="var(--border-strong)" stroke-width="1"/>
  <!-- Aligned arrows along +1 -->
  <line x1="82" y1="118" x2="122" y2="118" stroke="#10b981" stroke-width="3.2" marker-end="url(#arr-emerald)"/>
  <circle cx="124" cy="118" r="4" fill="#10b981"/>
  <text x="215" y="102" text-anchor="middle" font-size="11" font-weight="700" fill="#10b981">At ω = 2πk/T :</text>
  <text x="215" y="119" text-anchor="middle" font-size="10.5" fill="var(--text-secondary)">Each step rotates by 2πk</text>
  <text x="215" y="135" text-anchor="middle" font-size="10.5" font-weight="600" fill="var(--text-heading)">All 2N+1 arrows = +1</text>

  <!-- Sub-circle Bottom: Destructive (omega != 2pi k / T) -->
  <circle cx="82" cy="212" r="42" fill="none" stroke="var(--border-strong)" stroke-width="1.3" stroke-dasharray="3,3"/>
  <line x1="32" y1="212" x2="134" y2="212" stroke="var(--border-strong)" stroke-width="1"/>
  <line x1="82" y1="162" x2="82" y2="262" stroke="var(--border-strong)" stroke-width="1"/>
  <!-- Fanned out arrows -->
  <line x1="82" y1="212" x2="122" y2="212" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="108" y2="180" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="65" y2="174" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="42" y2="202" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="52" y2="240" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="96" y2="251" stroke="#3b82f6" stroke-width="1.6"/>
  <line x1="82" y1="212" x2="118" y2="232" stroke="#3b82f6" stroke-width="1.6"/>
  <text x="215" y="198" text-anchor="middle" font-size="11" font-weight="700" fill="#2563eb">At ω ≠ 2πk/T :</text>
  <text x="215" y="215" text-anchor="middle" font-size="10.5" fill="var(--text-secondary)">Arrows fan around circle</text>
  <text x="215" y="231" text-anchor="middle" font-size="10.5" font-weight="600" fill="var(--text-heading)">Oscillations cancel out</text>

  <!-- Right Panel: Dirichlet Kernel S_N(omega) -->
  <rect x="323" y="12" width="485" height="266" rx="10" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="565" y="35" text-anchor="middle" font-size="12.5" font-weight="700" fill="var(--text-heading)">2. The Finite-Sum Dirichlet Kernel S_N(ω) = sin((N+½)Tω) / sin(½Tω)</text>
  <text x="565" y="51" text-anchor="middle" font-size="10.5" fill="var(--text-muted)">Periodic peaks of height 2N+1, width 4π/((2N+1)T), and exact area 2π/T per period</text>

  <!-- Axes Right -->
  <line x1="345" y1="205" x2="788" y2="205" stroke="var(--text-secondary)" stroke-width="1.4"/>
  <line x1="566" y1="68" x2="566" y2="238" stroke="var(--text-secondary)" stroke-width="1.2" stroke-dasharray="3,3"/>
  <text x="786" y="222" text-anchor="end" font-size="10" fill="var(--text-muted)">ω</text>

  <!-- Period interval shading [-pi/T, pi/T] -->
  <rect x="496" y="72" width="140" height="133" fill="rgba(37, 99, 235, 0.06)"/>
  <line x1="496" y1="72" x2="496" y2="215" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="2,2"/>
  <line x1="636" y1="72" x2="636" y2="215" stroke="var(--border-strong)" stroke-width="1" stroke-dasharray="2,2"/>
  <text x="496" y="228" text-anchor="middle" font-size="9.5" fill="var(--text-muted)">−π/T</text>
  <text x="636" y="228" text-anchor="middle" font-size="9.5" fill="var(--text-muted)">+π/T</text>

  <!-- Dirichlet Kernel Curve with 3 main peaks at -2pi/T (426), 0 (566), +2pi/T (706) -->
  <path d="M 360 205 Q 368 192 376 205 Q 384 222 392 205 Q 400 182 408 205 Q 417 78 426 78 Q 435 78 444 205 Q 452 182 460 205 Q 468 222 476 205 Q 484 192 496 205 Q 508 192 516 205 Q 524 222 532 205 Q 540 182 548 205 Q 557 78 566 78 Q 575 78 584 205 Q 592 182 600 205 Q 608 222 616 205 Q 624 192 636 205 Q 648 192 656 205 Q 664 222 672 205 Q 680 182 688 205 Q 697 78 706 78 Q 715 78 724 205 Q 732 182 740 205 Q 748 222 756 205 Q 764 192 772 205" fill="none" stroke="#2563eb" stroke-width="2.2"/>

  <!-- Peak markers and labels -->
  <circle cx="426" cy="78" r="4" fill="#10b981"/>
  <circle cx="566" cy="78" r="4" fill="#10b981"/>
  <circle cx="706" cy="78" r="4" fill="#10b981"/>

  <text x="426" y="228" text-anchor="middle" font-size="10" font-weight="700" fill="var(--text-heading)">−2π/T</text>
  <text x="566" y="228" text-anchor="middle" font-size="10" font-weight="700" fill="var(--text-heading)">0</text>
  <text x="706" y="228" text-anchor="middle" font-size="10" font-weight="700" fill="var(--text-heading)">+2π/T</text>

  <text x="615" y="84" font-size="10" font-weight="700" fill="#10b981">Height = 2N + 1</text>
  <text x="566" y="260" text-anchor="middle" font-size="11" font-weight="600" fill="var(--brand-primary)">Signed area over [−π/T, π/T] = 2π/T for every N  ⟹  Weight = 2π/T</text>
</svg>
<figcaption class="diagram-caption">
  <strong>Figure 3 — From Rotating Phasors to the Dirichlet Kernel &amp; Periodic Dirac Comb.</strong> <strong>(1)</strong> At harmonic frequencies $\omega = \frac{2\pi k}{T}$, every phasor $e^{-inT\omega}$ completes an integer number of turns and points along $+1$. Away from harmonics, the phasors fan out around the unit circle. <strong>(2)</strong> Summing from $n = -N$ to $N$ yields the Dirichlet kernel $S_N(\omega)$, whose peaks at $\omega_k = \frac{2\pi k}{T}$ have height $2N+1$, width $\propto 1/N$, and conserved signed area $\frac{2\pi}{T}$ over each fundamental period $\left[-\frac{\pi}{T}, \frac{\pi}{T}\right]$.
</figcaption>
</figure>

---

#### 4. Why the Impulse Weight (Prefactor) Is $\frac{2\pi}{T}$

Why does each Dirac delta in the limit carry a weight of $\frac{2\pi}{T}$ rather than $1$? We can see this both **exactly** (by term-by-term integration) and **geometrically** (by height $\times$ width scaling):

1. **Exact Proof via Orthogonality over One Period $\left[-\frac{\pi}{T}, \frac{\pi}{T}\right]$:**  
   Integrate the finite sum $S_N(\omega)$ over one fundamental period centered at $\omega = 0$:

   $$
   \begin{aligned}
   \int_{-\pi/T}^{\pi/T} S_N(\omega) \, d\omega
   &= \sum_{n=-N}^{N} \int_{-\pi/T}^{\pi/T} e^{-inT\omega} \, d\omega \\
   &= \underbrace{\int_{-\pi/T}^{\pi/T} 1 \, d\omega}_{n = 0 \text{ term}} \; + \; \sum_{\substack{n=-N \\ n \neq 0}}^{N} \underbrace{\left[ \frac{e^{-inT\omega}}{-inT} \right]_{-\pi/T}^{\pi/T}}_{= \, 0 \text{ (full cycles)}} \\
   &= \frac{2\pi}{T}.
   \end{aligned}
   $$

   Every oscillatory mode $n \neq 0$ completes an exact integer number of cycles over $\left[-\frac{\pi}{T}, \frac{\pi}{T}\right]$ and integrates to **zero**! Only the constant $n=0$ term ($e^0 = 1$) contributes, yielding $1 \times \text{interval width} = \frac{2\pi}{T}$, **independently of $N$**.

2. **Geometric Scaling Intuition ($\text{Height} \times \text{Width}$):**  
   Notice that the peak height of $S_N(0)$ is $(2N+1)$ and the characteristic half-width from the peak to the first zero is $\frac{2\pi}{(2N+1)T}$. Multiplying height by characteristic width:

   $$
   \text{Peak Height} \times \text{Half-Width} = (2N + 1) \times \frac{2\pi}{(2N + 1)T} = \frac{2\pi}{T}.
   $$

   The factor of $(2N+1)$ cancels out! Thus, in the distributional limit $N \to \infty$, the Dirichlet kernel converges to a periodic Dirac comb with impulse weight $\frac{2\pi}{T}$:

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

### 2.4 The Dual Proof via Fourier Series of a Dirac Comb

We can also establish this identity in just three lines by running the logic in reverse—expanding the periodic frequency comb itself into a **Fourier series**!

Let $\Omega = \frac{2\pi}{T}$ be the fundamental frequency period. Because the Dirac comb distribution

$$
\operatorname{III}_{\Omega}(\omega) = \sum_{k=-\infty}^{\infty} \delta(\omega - k\Omega)
$$

is periodic in $\omega$ with period $\Omega$, it admits a complex Fourier series representation with fundamental "frequency" $\frac{2\pi}{\Omega} = T$:

$$
\operatorname{III}_{\Omega}(\omega) = \sum_{n=-\infty}^{\infty} c_n e^{inT\omega}.
$$

To find the Fourier coefficients $c_n$, integrate against $e^{-inT\omega}$ over one period $\left[-\frac{\Omega}{2}, \frac{\Omega}{2}\right]$:

$$
\begin{aligned}
c_n
&= \frac{1}{\Omega} \int_{-\Omega/2}^{\Omega/2} \operatorname{III}_{\Omega}(\omega) e^{-inT\omega} \, d\omega \\
&= \frac{1}{\Omega} \int_{-\Omega/2}^{\Omega/2} \delta(\omega) e^{-inT\omega} \, d\omega \\
&= \frac{1}{\Omega} e^{-inT(0)} = \frac{1}{\Omega} = \frac{T}{2\pi}.
\end{aligned}
$$

**Intuition:** Because the interval $\left[-\frac{\Omega}{2}, \frac{\Omega}{2}\right]$ contains only the single impulse $\delta(\omega)$ at $\omega = 0$, and $e^{-inT(0)} = 1$ for *every* $n$, **a Dirac impulse contains all harmonics $n \in \mathbb{Z}$ with equal weight $c_n = \frac{T}{2\pi}$!**

Substituting $c_n = \frac{T}{2\pi}$ back into the Fourier series (and noting that replacing $n \to -n$ leaves the symmetric sum over $\mathbb{Z}$ unchanged):

$$
\sum_{k=-\infty}^{\infty} \delta\left(\omega - \frac{2\pi k}{T}\right) = \frac{T}{2\pi} \sum_{n=-\infty}^{\infty} e^{inT\omega} = \frac{T}{2\pi} \sum_{n=-\infty}^{\infty} e^{-inT\omega}.
$$

Multiplying both sides by $\frac{2\pi}{T}$ immediately yields the crucial distributional identity:

$$
\boxed{
\sum_{n=-\infty}^{\infty} e^{-inT\omega}
=
\frac{2\pi}{T}
\sum_{k=-\infty}^{\infty}
\delta\left(\omega - \frac{2\pi k}{T}\right)
}
$$

---

### 2.5 Completing the DTFT Proof: Spectral Replication, the Nyquist Limit & Aliasing

With our distributional identity proven, we now substitute it back into the DTFT integral from Section 2.2:

$$
\begin{aligned}
X_s(\omega) 
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \left( \sum_{n=-\infty}^{\infty} e^{-inT(\omega - \theta)} \right) d\theta \\
&= \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\theta) \left[ \frac{2\pi}{T} \sum_{k=-\infty}^{\infty} \delta\left(\omega - \theta - \frac{2\pi k}{T}\right) \right] d\theta \\
&= \frac{1}{T} \sum_{k=-\infty}^{\infty} \int_{-\infty}^{\infty} X(\theta) \, \delta\left(\theta - \left(\omega - \frac{2\pi k}{T}\right)\right) d\theta
\end{aligned}
$$

Applying the sifting property of the Dirac delta to each term in the sum (evaluating $X(\theta)$ at $\theta = \omega - \frac{2\pi k}{T}$) completes the proof of the **DTFT Spectral Replication Theorem** (the Poisson Summation Formula in the frequency domain):

$$
\boxed{
X_s(\omega) = \sum_{n=-\infty}^{\infty} x(nT) e^{-inT\omega} = \frac{1}{T} \sum_{k=-\infty}^{\infty} X\left(\omega - \frac{2\pi k}{T}\right)
}
$$

Or, written equivalently in **linear frequency $f$ (in Hertz)** with sampling rate $f_s = \frac{1}{T}$:

$$
\boxed{
X_s(f) = f_s \sum_{k=-\infty}^{\infty} X(f - k f_s)
}
$$

#### What This Theorem Means Physically: Spectral Clones & The Nyquist Condition

Look at the right-hand side of our boxed theorem:
- For **$k = 0$**, we get $\frac{1}{T} X(\omega)$—the **true analog spectrum** of our continuous signal, centered at $\omega = 0$ and scaled in amplitude by $\frac{1}{T} = f_s$.
- For **$k = \pm 1, \pm 2, \pm 3, \dots$**, we get **infinite periodic clones (replicas)** of the continuous spectrum $X(\omega)$, shifted and centered at every integer multiple of the sampling rate $\omega_k = \frac{2\pi k}{T}$ (or $f = k f_s$)!

Suppose the continuous signal $x(t)$ is **band-limited** to a maximum angular frequency $\omega_{\max}$ (so $X(\omega) = 0$ for $|\omega| > \omega_{\max}$). When do the shifted clones stay separate, and when do they collide?

- **The $k=0$ baseband spectrum** spans $[-\omega_{\max}, +\omega_{\max}]$.
- **The $k=1$ replica** (centered at $\frac{2\pi}{T}$) extends leftward down to $\frac{2\pi}{T} - \omega_{\max}$.
- For the $k=0$ spectrum and the $k=1$ replica **not to overlap**, the right edge of the $k=0$ copy must lie strictly to the left of the left edge of the $k=1$ copy:

$$
\omega_{\max} < \frac{2\pi}{T} - \omega_{\max} \quad \Longleftrightarrow \quad \omega_{\max} < \frac{\pi}{T} = \frac{\Omega}{2} \quad \Longleftrightarrow \quad f_{\max} < \frac{f_s}{2} = f_{\text{Nyquist}}
$$

<figure class="diagram-figure">
<svg viewBox="0 0 820 330" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Visual comparison of original continuous spectrum, Nyquist-compliant sampling with disjoint spectral replicas, and undersampling causing spectral overlap and aliasing.">
  <!-- Row 1: Original Analog Spectrum X(omega) -->
  <rect x="12" y="10" width="796" height="92" rx="9" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="28" y="32" font-size="12" font-weight="700" fill="var(--text-heading)">A. Original Continuous-Time Spectrum X(ω)</text>
  <text x="790" y="32" text-anchor="end" font-size="11" fill="var(--text-muted)">Band-limited to [−ω_max, +ω_max]</text>

  <line x1="120" y1="82" x2="700" y2="82" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <line x1="410" y1="25" x2="410" y2="88" stroke="var(--text-secondary)" stroke-width="1.2" stroke-dasharray="3,2"/>
  <!-- Central baseband triangle/bell -->
  <path d="M 340 82 C 365 82, 385 34, 410 34 C 435 34, 455 82, 480 82 Z" fill="rgba(37, 99, 235, 0.22)" stroke="#2563eb" stroke-width="2.2"/>
  <text x="340" y="96" text-anchor="middle" font-size="9.5" font-weight="600" fill="#2563eb">−ω_max</text>
  <text x="410" y="96" text-anchor="middle" font-size="9.5" font-weight="700" fill="var(--text-heading)">0</text>
  <text x="480" y="96" text-anchor="middle" font-size="9.5" font-weight="600" fill="#2563eb">+ω_max</text>

  <!-- Row 2: Nyquist Satisfied (omega_max < pi/T) -->
  <rect x="12" y="114" width="796" height="100" rx="9" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="28" y="136" font-size="12" font-weight="700" fill="#10b981">B. Sampled Spectrum X_s(ω) — Fast Sampling (ω_max &lt; π/T : No Aliasing)</text>
  <text x="790" y="136" text-anchor="end" font-size="11" font-weight="600" fill="#10b981">Exact recovery via Low-Pass Filter</text>

  <line x1="120" y1="190" x2="700" y2="190" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <!-- Ideal Low-Pass Filter Box [-pi/T, +pi/T] -->
  <rect x="320" y="140" width="180" height="50" fill="rgba(16, 185, 129, 0.08)" stroke="#10b981" stroke-width="1.4" stroke-dasharray="4,3"/>
  <text x="410" y="136" text-anchor="middle" font-size="9.5" font-weight="700" fill="#10b981">Nyquist Box [−π/T, +π/T]</text>

  <!-- k = -1 replica centered at 230 -->
  <path d="M 160 190 C 185 190, 205 145, 230 145 C 255 145, 275 190, 300 190 Z" fill="rgba(100, 116, 139, 0.18)" stroke="#64748b" stroke-width="1.8"/>
  <!-- k = 0 baseband centered at 410 -->
  <path d="M 340 190 C 365 190, 385 145, 410 145 C 435 145, 455 190, 480 190 Z" fill="rgba(37, 99, 235, 0.22)" stroke="#2563eb" stroke-width="2.2"/>
  <!-- k = +1 replica centered at 590 -->
  <path d="M 520 190 C 545 190, 565 145, 590 145 C 615 145, 635 190, 660 190 Z" fill="rgba(100, 116, 139, 0.18)" stroke="#64748b" stroke-width="1.8"/>

  <text x="230" y="205" text-anchor="middle" font-size="9.5" font-weight="600" fill="var(--text-muted)">−2π/T (k=−1)</text>
  <text x="320" y="205" text-anchor="middle" font-size="9" fill="#10b981">−π/T</text>
  <text x="410" y="205" text-anchor="middle" font-size="9.5" font-weight="700" fill="var(--text-heading)">0 (k=0)</text>
  <text x="500" y="205" text-anchor="middle" font-size="9" fill="#10b981">+π/T</text>
  <text x="590" y="205" text-anchor="middle" font-size="9.5" font-weight="600" fill="var(--text-muted)">+2π/T (k=+1)</text>

  <!-- Row 3: Undersampling / Aliasing (omega_max > pi/T) -->
  <rect x="12" y="226" width="796" height="94" rx="9" fill="var(--bg-secondary)" stroke="var(--border-subtle)" stroke-width="1.2"/>
  <text x="28" y="248" font-size="12" font-weight="700" fill="#ef4444">C. Sampled Spectrum X_s(ω) — Slow Sampling (ω_max &gt; π/T : Spectral Aliasing!)</text>
  <text x="790" y="248" text-anchor="end" font-size="11" font-weight="600" fill="#ef4444">High frequencies fold into low band</text>

  <line x1="120" y1="300" x2="700" y2="300" stroke="var(--text-secondary)" stroke-width="1.3"/>
  <!-- Crowded replicas at 290, 410, 530 with width +/- 95 so they overlap! -->
  <path d="M 195 300 C 230 300, 260 255, 290 255 C 320 255, 350 300, 385 300 Z" fill="rgba(100, 116, 139, 0.16)" stroke="#64748b" stroke-width="1.7"/>
  <path d="M 315 300 C 350 300, 380 255, 410 255 C 440 255, 470 300, 505 300 Z" fill="rgba(37, 99, 235, 0.20)" stroke="#2563eb" stroke-width="2.1"/>
  <path d="M 435 300 C 470 300, 500 255, 530 255 C 560 255, 590 300, 625 300 Z" fill="rgba(100, 116, 139, 0.16)" stroke="#64748b" stroke-width="1.7"/>

  <!-- Highlight Overlap / Collision Zones [315..385] and [435..505] -->
  <path d="M 315 300 Q 335 292 350 278 Q 365 292 385 300 Z" fill="rgba(239, 68, 68, 0.45)" stroke="#ef4444" stroke-width="1.5"/>
  <path d="M 435 300 Q 455 292 470 278 Q 485 292 505 300 Z" fill="rgba(239, 68, 68, 0.45)" stroke="#ef4444" stroke-width="1.5"/>

  <text x="290" y="314" text-anchor="middle" font-size="9.5" fill="var(--text-muted)">−2π/T</text>
  <text x="350" y="272" text-anchor="middle" font-size="9.5" font-weight="700" fill="#ef4444">Overlap!</text>
  <text x="410" y="314" text-anchor="middle" font-size="9.5" font-weight="700" fill="var(--text-heading)">0</text>
  <text x="470" y="272" text-anchor="middle" font-size="9.5" font-weight="700" fill="#ef4444">Overlap!</text>
  <text x="530" y="314" text-anchor="middle" font-size="9.5" fill="var(--text-muted)">+2π/T</text>
</svg>
<figcaption class="diagram-caption">
  <strong>Figure 4 — Spectral Replication, the Nyquist Criterion &amp; Aliasing.</strong> <strong>(A)</strong> Continuous-time spectrum $X(\omega)$ supported on $[-\omega_{\max}, +\omega_{\max}]$. <strong>(B)</strong> When sampled at period $T$ satisfying $\omega_{\max} < \frac{\pi}{T}$ ($f_{\max} < f_s / 2$), the shifted replicas $X\left(\omega - \frac{2\pi k}{T}\right)$ remain disjoint; multiplying by an ideal box filter on $\left[-\frac{\pi}{T}, \frac{\pi}{T}\right]$ recovers $X(\omega)$ exactly. <strong>(C)</strong> When $T$ is too large ($\omega_{\max} > \frac{\pi}{T}$), adjacent copies collide and add together in the red overlap zones—irreversibly corrupting low frequencies (**aliasing**).
</figcaption>
</figure>

<div class="neuro-box" markdown="1">
<div class="callout-header">🧠 Practical Takeaway: Aliasing in Electrophysiology (EEG/LFP) &amp; fMRI BOLD</div>

Our spectral replication formula $X_s(f) = f_s \sum_{k=-\infty}^{\infty} X(f - k f_s)$ explains two critical phenomena in empirical neuroscience:

1. **Phantom Oscillations in LFP / EEG Recordings:**  
   Suppose you sample a cortical electrode at $f_s = 200\text{ Hz}$ ($T = 5\text{ ms}$), giving a Nyquist limit of $f_{\text{Nyquist}} = \frac{f_s}{2} = 100\text{ Hz}$. If the raw analog signal contains high-frequency **muscle (EMG) activity or extracellular spike energy at $f = 185\text{ Hz}$**, what happens in the sampled data?  
   The $k = 1$ replica shifts $+185\text{ Hz}$ to $185 - 200 = -15\text{ Hz}$, while the $k = -1$ replica shifts $-185\text{ Hz}$ to $-185 + 200 = +15\text{ Hz}$!  
   In your digital spectrum, that $185\text{ Hz}$ artifact appears as a **phantom $15\text{ Hz}$ Beta-band oscillation**! Once digitized, no software filter can distinguish the aliased $185\text{ Hz}$ energy from genuine $15\text{ Hz}$ cortical Beta activity. This is why every electrophysiology amplifier passes the analog voltage $x(t)$ through a hardware **analog anti-aliasing low-pass filter** *before* the ADC samples the signal.

2. **Physiological Aliasing in fMRI BOLD Time Series:**  
   In functional MRI, whole-brain volumes are typically acquired every $TR = T = 2.0\text{ s}$, corresponding to a sampling rate of $f_s = 0.5\text{ Hz}$ and a Nyquist limit of $f_{\text{Nyquist}} = 0.25\text{ Hz}$. While the sluggish hemodynamic response acts as a natural low-pass filter for neural activity, physiological **cardiac pulsations ($\sim 1.0\text{–}1.2\text{ Hz}$)** and **respiration ($\sim 0.25\text{–}0.35\text{ Hz}$)** lie above $f_{\text{Nyquist}} = 0.25\text{ Hz}$. By spectral replication, cardiac and respiratory fluctuations fold directly into the slow resting-state BOLD frequency band ($0.01\text{–}0.1\text{ Hz}$)—motivating explicit physiological noise modeling and linear time-invariant (LTI) hemodynamic observation models.
</div>
