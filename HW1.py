## Vyankatesh Change
## 1223508715
## MAE 598: Design Optimization

# HW1 problem 1 Solution

import scipy.optimize as spo


# Define Optimization function
def f(x):
    y = (x[0] - x[1]) ** 2 + (x[1] + x[2] - 2) ** 2 + (x[3] - 1) ** 2 + (x[4] - 1) ** 2
    return y


# Define Constraints
def cons1(x):
    return x[0] + x[1] * 3


def cons2(x):
    return x[2] + x[3] - 2 * x[4]


def cons3(x):
    return x[1] - x[4]

# Give constraint
constr1 = {'type': 'eq', 'fun': cons1}
constr2 = {'type': 'eq', 'fun': cons2}
constr3 = {'type': 'eq', 'fun': cons3}
constr = [constr1,constr2,constr3]

# Bounds limits for all the variables
b = [-10,10]
boundrylimit = (b,b,b,b,b)


# Initial guess
guess=[5,4,3,2,1]

print("Initial guess is",guess)

print("The solution for the initial guess is: ")

# Finally calculating the minimum value of the function

solution = spo.minimize(f,guess,bounds = boundrylimit,constraints = constr)
print(solution)
