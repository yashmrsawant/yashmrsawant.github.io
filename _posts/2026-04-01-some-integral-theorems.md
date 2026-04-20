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

<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

**(c)** If $$\text{Re}(w) > 0$$ and $$t$$ is a real constant, then

$$
\int_{-\infty}^{\infty} e^{-i 2\pi f t} e^{-wf^2} df = \frac{1}{\sqrt{2\pi}\sigma} e^{-\frac{t^2}{2\sigma^2}}
$$

where $$\sigma^2 = \frac{w}{2\pi^2}$$.

<details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Proof</summary>
  
  <br>
    
  First, we combine the exponents in the integrand:
  
  $$
  \int_{-\infty}^{\infty} e^{-wf^2 - i 2\pi t f} df
  $$
  
  We can evaluate this by applying the identity from **(a)**. Let our variable of integration be $$f$$ (instead of $$x$$), with constants $$a = w$$ and $$b = -i 2\pi t$$.
  
  Substituting these into the identity $$\int_{-\infty}^{\infty} e^{-ax^2+bx} dx = \sqrt{\frac{\pi}{a}}e^{b^2/(4a)}$$:
  
  $$
  \int_{-\infty}^{\infty} e^{-wf^2 - i 2\pi t f} df = \sqrt{\frac{\pi}{w}} e^{(-i 2\pi t)^2 / (4w)}
  $$
  
  Now, simplify the exponent:
  
  $$
  \frac{(-i 2\pi t)^2}{4w} = \frac{-4\pi^2 t^2}{4w} = -\frac{\pi^2 t^2}{w}
  $$
  
  This gives us the intermediate result:
  
  $$
  \int_{-\infty}^{\infty} e^{-i 2\pi f t} e^{-wf^2} df = \sqrt{\frac{\pi}{w}} e^{-\frac{\pi^2 t^2}{w}}
  $$
  
  Finally, we convert this back to a standard univariate Gaussian form by considering $$\sigma^2 = \frac{w}{2\pi^2}$$. 
  This substitution implies $$w = 2\pi^2\sigma^2$$ and $$\frac{\pi^2}{w} = \frac{1}{2\sigma^2}$$. 
  
  Substituting these into our intermediate result:
  
  $$
  \sqrt{\frac{\pi}{2\pi^2\sigma^2}} e^{-\frac{t^2}{2\sigma^2}} = \frac{1}{\sqrt{2\pi}\sigma} e^{-\frac{t^2}{2\sigma^2}}
  $$
  
</details>

</div>


<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

**(e)** **Geometric Intuition and Proof for the Sifting Property of a Nascent Delta Function**

We provide a visual proof for the following sifting property of a zero-mean Gaussian kernel.

*Note: For maximum visual clarity, we have simplified the integral by letting the constant $a=0$ and the signal be unshifted $x(t)$, which is equivalent to evaluating the value exactly at $t=0$. The sifting property states:*

$$
\lim_{\sigma \to 0} \int_{-\infty}^{\infty} x(t) \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{t^2}{2\sigma^2}} dt = x(0)
$$

We will walk through the progression shown in the image below, using five aligned panels to demonstrate how a sequence of narrowing and talling Gaussian kernels extracts a single point from a signal function.

<details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
  <summary style="font-weight: 600; color: #0969da;">Geometric Proof</summary>
  
  <br>
    
  We denote the Gaussian kernel as $$g_\sigma(t) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{t^2}{2\sigma^2}}$$. For any value of $$\sigma$$, the total area under this red curve is always exactly $$1$$:
  
  $$
  \int_{-\infty}^{\infty} g_\sigma(t) dt = 1
  $$
  
  Now, let's observe the behavior by considering five vertically aligned panels showing a common signal function $$x(t)$$ (the blue curve, defined as $$x(t) = \sin(t) + \cos(2t) + 3$$), and a sequence of decreasing $$\sigma$$ values. The integral is visualized as the area of the product $$x(t) \cdot g_\sigma(t)$$ (the lightly shaded red region).
  
  1.  **Panel 1: Broad Gaussian (large $$\sigma$$)**
      * Here, $$\sigma$$ is large ($$\sigma_1 = 1.0$$). The red kernel is wide and has a low peak.
      * **Geometric interpretation:** The integral calculates a weighted average of the signal over a very broad window.
      
  2.  **Panel 2: Narrows and Talls ($$\sigma_2 = \sigma_1 / 2$$)**
      * The effective width is halved ($$\sigma_2 = 0.5$$). The kernel becomes narrower and twice as tall (preserving the area of 1).
      * **Geometric interpretation:** The kernel concentrates more of its weighting closer to $$t=0$$. The shaded product area is shrinking inward.
      
  3.  **Panel 3: Narrows further ($$\sigma_3 = \sigma_2 / 2$$)**
      * Width halves again ($$\sigma_3 = 0.25$$). The red kernel is a distinct, tight spike.
      
  4.  **Panel 4: Almost a Spike ($$\sigma_4 = \sigma_3 / 2$$)**
      * Width halves one last time ($$\sigma_4 = 0.125$$). The red curve is extremely sharp.
      
  5.  **Panel 5: Limiting State: $$\sigma \to 0$$ (Dirac Delta)**
      * As $$\sigma \to 0$$, the red kernel has become an infinitely narrow and infinitely high vertical line, which we denote as the Dirac delta function, $$\delta(t)$$.
      * **Geometric interpretation:** As the red kernel continues to narrow, its shaded 'product' area with the blue signal must shrink. By the limit, the red 'line' has a width of exactly 0, meaning it can **only** weigh the height of the signal curve at that precise exact point. The value of the blue curve at this precise point is $x(0)$.
      
      Since the total 'weight' (area) of the Gaussian is fixed at $$1$$, and it only weighs the signal value $x(0)$, the result of the integral must be $$1 \times x(0)$$, or simply $$x(0)$$.
  
  $$
  \lim_{\sigma \to 0} \int_{-\infty}^{\infty} x(t) g_\sigma(t) dt = \int_{-\infty}^{\infty} x(t) \delta(t) dt = x(0)
  $$
  
  The magnified inset on the final panel explicitly shows this single point being extracted.
  
</details>
    
<p style="text-align: center; font-style: italic; color: #57606a;">
Figure: Visually demonstrating how the sifting property works as a Gaussian kernel limits to a Dirac delta function.
</p>
<img src="image_0.png" alt="A sequence of five horizontally aligned panels illustrating how a narrowing Gaussian concentrates its area around t=0 to extract a single signal value x(0). The progression from broad to infinitely narrow effectively isolates and extracts the function's height at the origin." style="max-width: 100%; height: auto; border: 1px solid #d0d7de; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.04); display: block; margin: 0 auto 16px;">
    
</div>

<div style="border: 1px solid #d0d7de; border-radius: 6px; padding: 20px; margin-bottom: 24px; background-color: #ffffff; box-shadow: 0 1px 3px rgba(0,0,0,0.04);" markdown="1">

**(d)** Proof of the Fourier Inversion:


<details style="cursor: pointer; padding: 10px; background-color: #f6f8fa; border-left: 4px solid #0969da; border-radius: 4px; margin-top: 15px;">
<summary style="font-weight: 600; color: #0969da;">Proof</summary>

The Fourier Transform and Its InverseGiven$$x(t)$$, a continuous-time signal, the Fourier Transform is defined as follows:
$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$To return to the time domain, we use the Inverse Fourier Transform (using the standard$$f$$convention without the scaling factor):$$x(t) = \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} df$$Proof of InversionTo show that the Fourier Transform and its inverse are indeed inverses of each other, we substitute the expression for$$X(f)$$into the Inverse Fourier Transform:$$x(t) = \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau} d\tau \right) e^{i 2\pi f t} df$$Interchanging the order of integration (which is justified under absolute integrability conditions for$$x(t)$$) gives us:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df \right) d\tau$$To evaluate the inner integral, let$$u = t - \tau$$. By Euler's formula, we can expand it as:$$\int_{-\infty}^{\infty} e^{i 2\pi f u} df = \int_{-\infty}^{\infty} \cos(2\pi f u) df + i \int_{-\infty}^{\infty} \sin(2\pi f u) df$$The sine term evaluates to 0 because$$\sin(2\pi f u)$$is an odd function integrated over a symmetric interval.To formally evaluate the remaining cosine integral, we introduce a Gaussian convergence factor$$e^{-a f^2}$$(where$$a > 0$$) and define$$I_a(u)$$:$$I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} df$$Our goal is to find$$I_a(u)$$and then take the limit as$$a \to 0$$.Differentiating$$I_a(u)$$with respect to$$u$$yields:$$\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} df$$We evaluate this using integration by parts ($$\int U \, dV = UV - \int V \, dU$$).Let$$U = \sin(2\pi f u)$$and$$dV = -2\pi f e^{-a f^2} df$$.This gives$$dU = 2\pi u \cos(2\pi f u) df$$and$$V = \frac{\pi}{a} e^{-a f^2}$$.$$\frac{dI_a(u)}{du} = \left[ \sin(2\pi f u) \left( \frac{\pi}{a} e^{-a f^2} \right) \right]_{f=-\infty}^{f=\infty} - \int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df$$Because the exponential term decays rapidly, the boundary evaluation is 0. We are left with:$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} e^{-a f^2} \cos(2\pi f u) df$$Substituting$$I_a(u)$$back into the right side forms a first-order linear differential equation:$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)$$Rearranging to separate variables:$$\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} du$$Integrating both sides:$$\ln(I_a(u)) = -\frac{\pi^2 u^2}{a} + C'$$Exponentiating to solve for$$I_a(u)$$:$$I_a(u) = C \exp\left(-\frac{\pi^2 u^2}{a}\right)$$To find the constant$$C$$, we evaluate$$I_a(u)$$at$$u=0$$:$$I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} df$$This standard Gaussian integral evaluates to$$\sqrt{\frac{\pi}{a}}$$, meaning$$C = \sqrt{\frac{\pi}{a}}$$. Thus:$$I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left(-\frac{\pi^2 u^2}{a}\right)$$To understand the behavior of this function as$$a \to 0$$, we can arrange$$I_a(u)$$to match the standard definition of the Gaussian probability density function with mean 0 and variance$$\sigma^2$$:$$\frac{1}{\sqrt{2\pi} \sigma} \exp\left(-\frac{u^2}{2\sigma^2}\right)$$By setting$$2\sigma^2 = \frac{a}{\pi^2}$$, we see our function is an exact, normalized Gaussian PDF. As$$a \to 0$$, the variance$$\sigma^2 \to 0$$and the amplitude approaches infinity, while the area remains 1. This is the formal definition of the Dirac delta function:$$\lim_{a \to 0} I_a(u) = \delta(u)$$Therefore, the inner integral of our original substitution evaluates to$$\delta(t - \tau)$$.Returning to our swapped integrals:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \left( \int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df \right) d\tau$$We substitute the delta function:$$x(t) = \int_{-\infty}^{\infty} x(\tau) \delta(t-\tau) d\tau$$Finally, applying the sifting property of the Dirac delta function, the integral picks out the value of$$x(\tau)$$exactly where$$\tau = t$$:$$x(t) = x(t)$$This completes the proof.</details>