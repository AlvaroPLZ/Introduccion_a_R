import numpy as np
import matplotlib.pyplot as plt
from scipy import stats  # Importa el módulo stats

# Fijamos la semilla para reproducibilidad
np.random.seed(42)

# 1. Distribución Normal (μ=0, σ=0.2)
mu, sigma = 0, 0.2  # media y desviación estándar
normal = stats.norm(mu, sigma)
x = np.linspace(normal.ppf(0.01),
                normal.ppf(0.99), 100)
fp = normal.pdf(x)  # Función de densidad
plt.plot(x, fp)
plt.title('Distribución Normal')
plt.ylabel('Densidad')
plt.xlabel('Valores')
plt.show()

# 2. Distribución Binomial (n=30, p=0.4)
N, p = 30, 0.4  # parámetros de forma
binomial = stats.binom(N, p)  # Distribución binomial
x = np.arange(binomial.ppf(0.01),
              binomial.ppf(0.99))
fmp = binomial.pmf(x)  # Función de masa de probabilidad
plt.plot(x, fmp, '--')
plt.vlines(x, 0, fmp, colors='b', lw=5, alpha=0.5)
plt.title('Distribución Binomial')
plt.ylabel('Probabilidad')
plt.xlabel('Valores')
plt.show()

# 3. Distribución de Poisson (λ=3.6)
mu_poisson = 3.6  # parámetro
poisson = stats.poisson(mu_poisson)
x = np.arange(poisson.ppf(0.01),
              poisson.ppf(0.99))
fmp = poisson.pmf(x)  # Función de masa de probabilidad
plt.plot(x, fmp, '--')
plt.vlines(x, 0, fmp, colors='b', lw=5, alpha=0.5)
plt.title('Distribución Poisson')
plt.ylabel('Probabilidad')
plt.xlabel('Valores')
plt.show()

# 4. Distribución Exponencial (λ=1, scale=1)
exponencial = stats.expon()
x = np.linspace(exponencial.ppf(0.01),
                exponencial.ppf(0.99), 100)
fp = exponencial.pdf(x)  # Función de densidad
plt.plot(x, fp)
plt.title('Distribución Exponencial')
plt.ylabel('Densidad')
plt.xlabel('Valores')
plt.show()

# 5. Distribución Uniforme (entre 0 y 1)
uniforme = stats.uniform()  # Por defecto: loc=0, scale=1
x = np.linspace(uniforme.ppf(0.01),
                uniforme.ppf(0.99), 100)
fp = uniforme.pdf(x)  # Función de densidad
fig, ax = plt.subplots()
ax.plot(x, fp, '--')
ax.vlines(x, 0, fp, colors='b', lw=5, alpha=0.5)
ax.set_yticks([0., 0.2, 0.4, 0.6, 0.8, 1., 1.2])
plt.title('Distribución Uniforme')
plt.ylabel('Densidad')
plt.xlabel('Valores')
plt.show()

# 6. Distribución Bernoulli (p=0.5)
p_bern = 0.5  # parámetro
bernoulli = stats.bernoulli(p_bern)
x = np.arange(-1, 3)
fmp = bernoulli.pmf(x)  # Función de masa de probabilidad
fig, ax = plt.subplots()
ax.plot(x, fmp, 'bo')
ax.vlines(x, 0, fmp, colors='b', lw=5, alpha=0.5)
ax.set_yticks([0., 0.2, 0.4, 0.6])
plt.title('Distribución Bernoulli')
plt.ylabel('Probabilidad')
plt.xlabel('Valores')
plt.show()

# 7. Distribución Gamma (forma=2.6, escala=1 por defecto)
a = 2.6  # parámetro de forma
gamma = stats.gamma(a)
x = np.linspace(gamma.ppf(0.01),
                gamma.ppf(0.99), 100)
fp = gamma.pdf(x)  # Función de densidad
plt.plot(x, fp)
plt.title('Distribución Gamma')
plt.ylabel('Densidad')
plt.xlabel('Valores')
plt.show()

# 8. Distribución Geométrica (p=0.3)
p_geom = 0.3  # parámetro
geometrica = stats.geom(p_geom)
x = np.arange(geometrica.ppf(0.01),
              geometrica.ppf(0.99))
fmp = geometrica.pmf(x)  # Función de masa de probabilidad
plt.plot(x, fmp, '--')
plt.vlines(x, 0, fmp, colors='b', lw=5, alpha=0.5)
plt.title('Distribución Geométrica')
plt.ylabel('Probabilidad')
plt.xlabel('Valores')
plt.show()