---
layout: default
title: "Some useful Gaussian Integrals"
date: 2026-04-01
categories: [integrals-theorems]
---
# Some useful Gaussian Integrals

(a) If $$a > 0$$ and $$b$$ is real constant, then

$$\int_{-\infty}^{\infty} dx (e^{-ax^2+bx})=\frac{1}{2}\sqrt{\frac{\pi}{a}}e^{b^2/(4a)}\text{ }$$
<details style="cursor: pointer; padding: 10px; background-color: #f8f9fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Click to show/hide the proof</summary>
  
  <br>
  
  **Proof:**
  
  First, we complete the square in the exponent:
  
  $$
  -ax^2 + bx = -a\left(x^2 - \frac{b}{a}x\right) = -a\left(x - \frac{b}{2a}\right)^2 + \frac{b^2}{4a}
  $$
  
  Substitute this back into the integral:
  
  $$
  \int_{-\infty}^{\infty} e^{-a(x - \frac{b}{2a})^2 + \frac{b^2}{4a}} dx = e^{b^2/(4a)} \int_{-\infty}^{\infty} e^{-a(x - \frac{b}{2a})^2} dx
  $$
  
  Now, perform a substitution let $u = x - \frac{b}{2a}$, so $du = dx$. The limits of integration remain $-\infty$ to $\infty$:
  
  $$
  e^{b^2/(4a)} \int_{-\infty}^{\infty} e^{-au^2} du
  $$
  
  We know the standard Gaussian integral evaluates to $\sqrt{\frac{\pi}{a}}$. Thus:
  
  $$
  e^{b^2/(4a)} \sqrt{\frac{\pi}{a}}
  $$
  
</details>