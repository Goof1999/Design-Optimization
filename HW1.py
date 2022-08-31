## Vyankatesh Change
## 1223508715
## MAE 598: Design Optimization

# HW1 problem 1 Solution

import scipy.optimize as spo
import numpy as np


# Define Optimization function
def f(x1, x2, x3, x4, x5):
    y = (x1 - x2) ** 2 - (x2 + x3 - 2) ** 2 + (x4 - 1) ** 2 + (x5 - 1) ** 2
    return y


# Define Constraints
def cons1(x1, x2):
    return x1 + x2 * 3


def cons2(x3, x4, x5):
    return x3 + x4 - 2 * x5


def cons3(x2, x5):
    return x2 - x5


# Initial guess
ini = [1, 1, 1, 1, 1]

# Bounds
b = (-10,10)
boundry = (b,b,b,b,b)

constr1 = {'type': 'eq', 'fun': cons1}
constr2 = {'type': 'eq', 'fun': cons2}
constr3 = {'type': 'eq', 'fun': cons3}
constr = [constr1,constr2,constr3]

solution = spo.minimize(f,ini,bounds = boundry,constraints = constr)
print(solution)
