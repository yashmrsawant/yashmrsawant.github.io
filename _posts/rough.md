

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
