

$$
I(t) = \int_{-\infty}^{\infty} \exp(-j\omega t) \, d\omega
$$

To solve this integra, we can construct another integral that is easier to evaluate. 

$$
I_a(t) = \int_{-\infty}^{\infty} \exp(-j\omega t - a \omega^2) \, d\omega
$$

And as we can see, as $a \to 0$, $I_a(t) \to I(t)$.

To evaluate $I_a(t)$ - 

$$
I_a(t) = \int_{-\infty}^{\infty} \cos(wt) \exp(-a \omega^2) \, d\omega - j \int_{-\infty}^{\infty} \sin(\omega t) \exp(-a \omega^2) \, d\omega
$$

Now, the second integral is zero because $\sin(\omega t)$ is an odd function and $\exp(-a \omega^2)$ is an even function. So we are left with -

$$
I_a(t) = \int_{-\infty}^{\infty} \cos(\omega t) \exp(-a\omega^2)\, d\omega
$$

To evaluate $I_a(t)$, we can differentiate it with respect to $t$ -
$$
\frac{dI_a(t)}{dt} = -\int_{-\infty}^{\infty} \omega \sin(\omega t) \exp(-a \omega^2) \, d\omega
$$

Now, integration by parts 
$$
\int u \, dv = uv - \int v \, du
$$

Let $u = \sin(\omega t)$ and $dv = \omega \exp(-a \omega^2) d\omega$. Then, $du = t \cos(\omega t) d\omega$ and $v = -\frac{1}{2a} \exp(-a \omega^2)$.

Therefore, 
$$
\frac{dI_a(t)}{dt} = -\left[ -\frac{1}{2a} \sin(\omega t) \exp(-a \omega^2) \right]_{-\infty}^{\infty} + \frac{t}{2a} \int_{-\infty}^{\infty} \cos(\omega t) \exp(-a \omega^2) \, d\omega
$$

First term above will be zero because $\sin(\omega t)$ is an odd function and $\exp(-a \omega^2)$ is an even function. So we are left with -
$$
\frac{dI_a(t)}{dt} = \frac{t}{2a} I_a(t)
$$
This is a first order linear differential equation. We can solve it using the integrating factor method. The integrating factor is given by -
$$
\mu(t) = \exp\left( \int \frac{t}{2a} dt \right) = \exp\left( \frac{t^2}{4a} \right)
$$
Therefore,
$$
\frac{dI_a(t)}{dt} = \frac{t}{2a} I_a(t) \exp\left( \frac{t^2}{4a} \right)
$$
Integrating both sides with respect to $t$ gives us -
$$
I_a(t) \exp\left( \frac{t^2}{4a} \right) = C
$$
where $C$ is a constant of integration. Therefore,
$$
I_a(t) = C \exp\left( -\frac{t^2}{4a} \right)
$$To find the constant $C$, we can evaluate $I_a(0)$ -
$$
I_a(0) = \int_{-\infty}^{\infty} \exp(-a \omega^2) \, d\omega
$$
This is a Gaussian integral and can be evaluated as follows -
$$
I_a(0) = \sqrt{\frac{\pi}{a}}
$$
Therefore,
$$
C = \sqrt{\frac{\pi}{a}} \exp\left( -\frac{t^2}{4a} \right)
$$

Thus, we have
$$
I_a(t) = \sqrt{\frac{\pi}{a}} \exp\left( -\frac{t^2}{4a} \right)
$$Now, as $a \to 0$, we can see that $I_a(t) \to I(t)$ becomes a delta function. 


# The Fourier Transform
Given $x(t)$, a continuous-time signal, 
the Fourier Transform is defined as follows:

$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$
The operation is defined by the integral, which compares our signal against complex sinusoids of every possible frequency:

To return to the time domain, we use the **Inverse Fourier Transform**:

$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} X(f) e^{i 2\pi f t} df$$

Proof: 

To show that the Fourier Transform and its inverse are indeed inverses of each other, we can substitute the expression for $X(f)$ into the inverse Fourier Transform:
$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \left( \int_{-\infty}^{\infty} x(\tau) e^{-i 2\pi f \tau} d\tau \right) e^{i 2\pi f t} df$$
Interchanging the order of integration (which is justified under certain conditions on $x(t)$, such as absolute integrability) gives us:
$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} x(\tau) \int_{-\infty}^{\infty}  e^{i 2\pi f (t-\tau)}  df \,d\tau$$


To evaluate the inner integral, we can write it as:

$$
\int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df = \int_{-\infty}^{\infty} e^{i 2\pi f u} df = \int_{-\infty}^{\infty} \cos(2\pi f u) df + i \int_{-\infty}^{\infty} \sin(2\pi f u) df
$$

The sine term evaluates to zero because $\sin(2\pi f u)$ is an odd function. 

To evaluate the cosine term, we manipulate the integral as follows:

$$
I_a(u) = \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} df
$$

Because as $a \to 0$, $I_a(u) \to \int_{-\infty}^{\infty} \cos(2\pi f u) df$. We can evaluate $I_a(u)$ using the same method as before, which yields:

Differentiating $I_a(u)$ with respect to $u$ gives us:
$$
\frac{dI_a(u)}{du} = -\int_{-\infty}^{\infty} 2\pi f \sin(2\pi f u) e^{-a f^2} df
$$

To remind integration by parts 
$$
\int u \, dv = uv - \int v \, du
$$

Consider $u = \sin(2\pi f u)$ and $dv = -2\pi fe^{-a f^2} df$.

$$\frac{dI_a(u)}{du} = \left[ \sin(2\pi f u) \left( \frac{\pi}{a} e^{-a f^2} \right) \right]_{f=-\infty}^{f=\infty} - \int_{-\infty}^{\infty} \left( \frac{\pi}{a} e^{-a f^2} \right) \left( 2\pi u \cos(2\pi f u) \right) df$$

$$\frac{dI_a(u)}{du} = 0 - \frac{2\pi^2 u}{a} \int_{-\infty}^{\infty} e^{-a f^2} \cos(2\pi f u) df$$

$$\frac{dI_a(u)}{du} = -\frac{2\pi^2 u}{a} I_a(u)$$

Rearranging

$$
\frac{dI_a(u)}{I_a(u)} = -\frac{2\pi^2 u}{a} du
$$

Integrating both sides:
$$
\ln(I_a(u)) = -\frac{2\pi^2 u^2}{2a} + C'
$$


$$I_a(u) = \exp\left(-\frac{\pi^2 u^2}{a} + C'\right) = C \exp\left(-\frac{\pi^2 u^2}{a}\right)$$

To find the constant $C$, we evaluate $I_a(u)$ at $u=0$:
$$I_a(0) = \int_{-\infty}^{\infty} e^{-a f^2} df$$
This is a standard Gaussian integral, which evaluates to:

$$I_a(0) = \sqrt{\frac{\pi}{a}}$$


Thus, we have
$$
I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left(-\frac{\pi^2 u^2}{a}\right)
$$


Now,
$$
\int_{-\infty}^{\infty} e^{i 2\pi f (t-\tau)} df = \int_{-\infty}^{\infty} e^{i 2\pi f u} df = \int_{-\infty}^{\infty} \cos(2\pi f u) df + i \int_{-\infty}^{\infty} \sin(2\pi f u) df
$$

To evaluate the inner integral, we can write it as:

$$
\int_{-\infty}^{\infty} \cos(2\pi f u) df = \lim_{a \to 0} \int_{-\infty}^{\infty} \cos(2\pi f u) e^{-a f^2} df = \lim_{a \to 0} \sqrt{\frac{\pi}{a}} \exp\bigg(-\frac{\pi^2 u^2}{a}\bigg)
$$

We can arrange $I_a(u)$ to match the standard definition of the Gaussian distribution with mean $0$ and variance $\sigma^2$:

$$
I_a(u) = \sqrt{\frac{\pi}{a}} \exp\left(-\frac{\pi^2 u^2}{a}\right) = \frac{1}{\sqrt{2\pi} \sigma} \exp\left(-\frac{u^2}{2\sigma^2}\right)
$$

By letting $2\sigma^2 = \frac{a}{\pi^2}$, we can rewrite $I_a(u)$ as:

$$
I_a(u) = \delta(u)
$$


$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} x(\tau) \int_{-\infty}^{\infty}  e^{i 2\pi f (t-\tau)}  df \,d\tau$$
$$x(t) = \frac{1}{2\pi} \int_{-\infty}^{\infty} x(\tau) \delta(t-\tau) d\tau$$

Finally, we can evaluate the integral using the sifting property of the delta function: