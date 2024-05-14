import time
import numpy as np
cimport numpy as np
np.import_array()
from libc.math cimport fmax, cos


def sum_matrices(double[:, ::1] A, double[:, ::1] B):
    """Sum two matrices."""
    # Here we declare the arguments that we want to be typed.
    # They do not need to be declared before the rest of the code
    # like Fortran, but sometimes this is simpler.
    cdef:
        int dim_A0=A.shape[0], dim_A1=A.shape[1]
        Py_ssize_t i, j  # The type Py_ssize_t is usually used for loops.

    # In def methods we do not need to type every variable.
    dim_B0 = B.shape[0]
    dim_B1 = B.shape[1]

    if dim_A0 != dim_B0 or dim_A1 != dim_B1:
        raise Exception(f"The shape of matrices A: {A.shape} and B: {B.shape} does not coincide.")

    # Another non typed variable. In this case a Numpy array.
    C = np.empty((dim_A0, dim_A1))

    for i in range(dim_A0):
        for j in range(dim_A1):
            C[i, j] = A[i, j] + B[i, j]

    return C


def do_complex_array_operation(double[::1] a, double[::1] b):
    """Complex array operation.
    
    In Numpy, the operation reads:
    out = np.sum( np.cos(a + 2 * b) + np.maximum(a**2, b) )
    
    """
    if a.shape[0] != b.shape[0]:
        raise Exception(f"The size of vectors a: {a.shape} and b: {b.shape} does not coincide.")

    # Call a C method to do the computation.
    cdef double out = _do_complex_array_operation(a, b)

    return out


# This is a kind of method that only works with C objects. Here we can call
# C methods like math::fabs or math::cos. In these methods we have to type
# every variable.
cdef double _do_complex_array_operation(double[::1] a, double[::1] b):
    cdef:
        Py_ssize_t n=a.shape[0]
        Py_ssize_t i
        double out=0.0

    for i in range(n):
        out += cos(a[i] + 2 * b[i]) + fmax(a[i]**2, b[i])

    return out