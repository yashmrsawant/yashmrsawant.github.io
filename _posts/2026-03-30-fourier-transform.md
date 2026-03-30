---
layout: default
title: "Fourier Transform"
date: 2026-03-30
categories: [signal processing, time-series analysis]
---

# Continuous-Time Fourier Transform (CTFT)

The CTFT translates a continuous-time neural signal into a continuous-frequency spectrum.

## Mathematical Definition

The operation is defined by the following integral:

$$X(f) = \int_{-\infty}^{\infty} x(t) e^{-i 2\pi f t} dt$$

## Variables and Physical Units

When applying this to a continuous-time neural voltage signal, denoted as $x(t)$:

* $$x(t)$$: The continuous-time signal, with units in millivolts (mV).
* $$t$$: Time, with units in seconds (s).
* $$dt$$: The differential integration step over time, measured in seconds.
* $$f$$: The frequency variable, measured in Hertz (Hz).
