---
layout: default
title: "Some useful Gaussian Integrals"
date: 2026-04-01
categories: [integrals-theorems]
---

# Some Useful Gaussian Integrals

<div style="
border: 1px solid #d0d7de;
border-radius: 6px;
padding: 20px;
margin-bottom: 24px;
background-color: #ffffff;
box-shadow: 0 1px 3px rgba(0,0,0,0.04);
" markdown="1">

## (a) Proof of the Fourier Inversion Theorem

<details style="
cursor: pointer;
padding: 10px;
background-color: #f6f8fa;
border-left: 4px solid #0969da;
border-radius: 4px;
margin-top: 15px;
">

<summary style="font-weight: 600; color: #0969da;">
Proof
</summary>


Fourier Transform and Its Inverse

Given \( x(t) \), a continuous-time signal, the Fourier Transform is defined as:

$$
X(f) = \int_{-\infty}^{\infty}
x(t)\, e^{-i 2\pi f t}\, dt
$$

To return to the time domain, we use the inverse transform:

$$
x(t) =
\int_{-\infty}^{\infty}
X(f)\, e^{i 2\pi f t}\, df
$$

---

### Substituting the Transform

Substitute \( X(f) \) into the inverse transform:

$$
x(t) =
\int_{-\infty}^{\infty}
\left(
\int_{-\infty}^{\infty}
x(\tau)
e^{-i 2\pi f \tau}
\, d\tau
\right)
e^{i 2\pi f t}
\, df
$$

Interchanging the order of integration:

$$
x(t) =
\int_{-\infty}^{\infty}
x(\tau)
\left(
\int_{-\infty}^{\infty}
e^{i 2\pi f (t-\tau)}
\, df
\right)
d\tau
$$

Let:

$$
u = t - \tau
$$

---

### Evaluating the Inner Integral

Using Euler's formula:

$$
\int_{-\infty}^{\infty}
e^{i 2\pi f u}
\, df
=
\int_{-\infty}^{\infty}
\cos(2\pi f u)\, df
+
i
\int_{-\infty}^{\infty}
\sin(2\pi f u)\, df
$$

The sine term vanishes since it is an odd function over a symmetric interval.

We therefore evaluate:

$$
I_a(u)
=
\int_{-\infty}^{\infty}
\cos(2\pi f u)
e^{-a f^2}
\, df
$$

where \( a > 0 \).

---

### Differentiation Step

Differentiate:

$$
\frac{dI_a(u)}{du}
=
-\int_{-\infty}^{\infty}
2\pi f
\sin(2\pi f u)
e^{-a f^2}
\, df
$$

Using integration by parts:

Let

$$
U = \sin(2\pi f u)
$$

$$
dV = -2\pi f e^{-a f^2} df
$$

Then

$$
dU = 2\pi u \cos(2\pi f u) df
$$

$$
V = \frac{\pi}{a} e^{-a f^2}
$$

This gives:

$$
\frac{dI_a(u)}{du}
=
-\frac{2\pi^2 u}{a}
\int_{-\infty}^{\infty}
e^{-a f^2}
\cos(2\pi f u)
\, df
$$

Thus:

$$
\frac{dI_a(u)}{du}
=
-\frac{2\pi^2 u}{a}
I_a(u)
$$

---

### Solving the Differential Equation

Separate variables:

$$
\frac{dI_a(u)}{I_a(u)}
=
-\frac{2\pi^2 u}{a}
du
$$

Integrate:

$$
\ln I_a(u)
=
-\frac{\pi^2 u^2}{a}
+ C'
$$

Exponentiate:

$$
I_a(u)
=
C
\exp\left(
-\frac{\pi^2 u^2}{a}
\right)
$$

---

### Determining the Constant

At \( u = 0 \):

$$
I_a(0)
=
\int_{-\infty}^{\infty}
e^{-a f^2}
df
=
\sqrt{\frac{\pi}{a}}
$$

Thus:

$$
I_a(u)
=
\sqrt{\frac{\pi}{a}}
\exp\left(
-\frac{\pi^2 u^2}{a}
\right)
$$

---

### Limit to the Dirac Delta

This expression matches a Gaussian PDF form.

As:

$$
a \to 0
$$

the variance approaches zero and:

$$
\lim_{a \to 0}
I_a(u)
=
\delta(u)
$$

Thus:

$$
\int_{-\infty}^{\infty}
e^{i 2\pi f (t-\tau)}
df
=
\delta(t-\tau)
$$

---

### Final Step

Substitute:

$$
x(t)
=
\int_{-\infty}^{\infty}
x(\tau)
\delta(t-\tau)
d\tau
$$

Using the sifting property:

$$
x(t) = x(t)
$$

Note: If the below integral transform is used for computing the Fourier Transform:
$$
X(\omega) = \int_{-\infty}^{\infty} x(t) e^{-i \omega t} dt
$$

Then the Inverse Fourier transform is given by:

$$
x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(\omega) e^{i \omega t} d\omega
$$
---

</details>

</div>