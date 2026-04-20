---
layout: default
title: "Some useful Gaussian Integrals"
date: 2026-04-01
categories: [integrals-theorems]
---

# Some useful Gaussian Integrals

<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

  **(a)** Proof of the Fourier Inversion Theorem:
  <details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Proof</summary>

  The Fourier Transform and Its Inverse

    Given $$x(t)$$, a continuous-time signal, the Fourier Transform is defined as follows:
    $$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$

    To return to the time domain, we use the Inverse Fourier Transform (using the standard $$f$$ convention without the scaling factor):
    $$x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} df$$
    
    Proof of InversionTo show that the Fourier Transform and its inverse are indeed inverses of each other, we substitute the expression for$$X(f)$$into the Inverse Fourier Transform:$$x(t) = \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau} d\tau \right) e^{i 2\pi f t} df$$Interchanging the order of integration (which is justified under absolute integrability conditions for$$x(t)$$) gives us:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df \right) d\tau$$To evaluate the inner integral, let$$u = t - \tau$$. By Euler's formula, we can expand it as:$$\int_{-\infty}^{\infty} e^{i 2\pi f u} df = \int_{-\infty}^{\infty} \cos(2\pi f u) df + i \int_{-\infty}^{\infty} \sin(2\pi f u) df$$The sine term evaluates to 0 because$$\sin(2\pi f u)$$is an odd function integrated over a symmetric interval.To formally evaluate the remaining cosine integral, we introduce a Gaussian convergence factor$$e^{-a f^2}$$(where$$a > 0$$) and define$$I_a(u)$$:$$I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} df$$Our goal is to find$$I_a(u)$$and then take the limit as$$a \to 0$$.Differentiating$$I_a(u)$$with respect to$$u$$yields:$$\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} df$$We evaluate this using integration by parts ($$\int U \, dV = UV - \int V \, dU$$).Let$$U = \sin(2\pi f u)$$and$$dV = -2\pi f e^{-a f^2} df$$.This gives$$dU = 2\pi u \cos(2\pi f u) df$$and$$V = \frac{\pi}{a} e^{-a f^2}$$.$$\frac{dI_a(u)}{du} = \left[ \sin(2\pi f u) \left( \frac{\pi}{a} e^{-a f^2} \right) \right]_{f=-\infty}^{f=\infty} - \int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df$$Because the exponential term decays rapidly, the boundary evaluation is 0. We are left with:$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} e^{-a f^2} \cos(2\pi f u) df$$Substituting$$I_a(u)$$back into the right side forms a first-order linear differential equation:$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)$$Rearranging to separate variables:$$\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} du$$Integrating both sides:$$\ln(I_a(u)) = -\frac{\pi^2 u^2}{a} + C'$$Exponentiating to solve for$$I_a(u)$$:$$I_a(u) = C \exp\left(-\frac{\pi^2 u^2}{a}\right)$$To find the constant$$C$$, we evaluate$$I_a(u)$$at$$u=0$$:$$I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} df$$This standard Gaussian integral evaluates to$$\sqrt{\frac{\pi}{a}}$$, meaning$$C = \sqrt{\frac{\pi}{a}}$$. Thus:$$I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left(-\frac{\pi^2 u^2}{a}\right)$$To understand the behavior of this function as$$a \to 0$$, we can arrange$$I_a(u)$$to match the standard definition of the Gaussian probability density function with mean 0 and variance$$\sigma^2$$:$$\frac{1}{\sqrt{2\pi} \sigma} \exp\left(-\frac{u^2}{2\sigma^2}\right)$$By setting$$2\sigma^2 = \frac{a}{\pi^2}$$, we see our function is an exact, normalized Gaussian PDF. As$$a \to 0$$, the variance$$\sigma^2 \to 0$$and the amplitude approaches infinity, while the area remains 1. This is the formal definition of the Dirac delta function:$$\lim_{a \to 0} I_a(u) = \delta(u)$$Therefore, the inner integral of our original substitution evaluates to$$\delta(t - \tau)$$.Returning to our swapped integrals:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df \right) d\tau$$We substitute the delta function:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \delta(t-\tau) d\tau$$Finally, applying the sifting property of the Dirac delta function, the integral picks out the value of$$x(\tau)$$exactly where$$\tau = t$$:$$x(t) = x(t)$$

</details>