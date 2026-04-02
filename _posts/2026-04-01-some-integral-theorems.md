---
layout: default
title: "Some useful Gaussian Integrals"
date: 2026-04-01
categories: [integrals-theorems]
---

# Some useful Gaussian Integrals

<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

**(a)** If $$a > 0$$ and $$b$$ is a real constant, then

$$
\int_{-\infty}^{\infty} e^{-ax^2+bx} dx = \sqrt{\frac{\pi}{a}}e^{b^2/(4a)}
$$

<details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Proof</summary>
  
  <br>
    
  First, we complete the square in the exponent:
  
  $$
  -ax^2 + bx = -a\left(x^2 - \frac{b}{a}x\right) = -a\left(x - \frac{b}{2a}\right)^2 + \frac{b^2}{4a}
  $$
  
  Substitute this back into the integral:
  
  $$
  \int_{-\infty}^{\infty} e^{-a(x - \frac{b}{2a})^2 + \frac{b^2}{4a}} dx = e^{b^2/(4a)} \int_{-\infty}^{\infty} e^{-a(x - \frac{b}{2a})^2} dx
  $$
  
  Now, perform a substitution let $$u = x - \frac{b}{2a}$$, so $$du = dx$$. 
  The limits of integration remain $$-\infty$$ to $$\infty$$:
  
  $$
  e^{b^2/(4a)} \int_{-\infty}^{\infty} e^{-au^2} du
  $$
  
  We know the standard Gaussian integral evaluates to $$\sqrt{\frac{\pi}{a}}$$. Thus:
  
  $$
  \int_{-\infty}^{\infty} e^{-ax^2+bx} dx = e^{b^2/(4a)} \sqrt{\frac{\pi}{a}}
  $$
  
</details>

</div>

<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

**(b)** Shorthand notation for integral of complex exponential:

$$
\int_{-\infty}^{\infty} \exp(-ixk)dx=2\pi\delta(k)
$$

where $$\delta(k)$$ is the Dirac delta function.

<details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Proof</summary>
  
  <br>
    
  This integral can be evaluated by considering it over a finite symmetric interval $$[-L, L]$$and then taking the limit as$$L \to \infty$$:
  
  $$
  \int_{-L}^{L} e^{-ixk} dx = \left[ \frac{e^{-ixk}}{-ik} \right]_{-L}^{L} = \frac{e^{-iLk} - e^{iLk}}{-ik}
  $$
  
  Using Euler's formula, we know that $$e^{i\theta} - e^{-i\theta} = 2i\sin(\theta)$$. Applying this gives:
  
  $$
  \frac{e^{-iLk} - e^{iLk}}{-ik} = \frac{-2i \sin(Lk)}{-ik} = 2\frac{\sin(Lk)}{k}
  $$
  
  Taking the limit as $$L \to \infty$$, we can use the well-known Dirichlet kernel representation of the Dirac delta function, where $$\lim_{L \to \infty} \frac{\sin(Lk)}{\pi k} = \delta(k)$$:
  
  $$
  \lim_{L \to \infty} \int_{-L}^{L} e^{-ixk} dx = 2\pi \lim_{L \to \infty} \frac{\sin(Lk)}{\pi k} = 2\pi\delta(k)
  $$
  
</details>

</div>