import time
import numpy as np
cimport numpy as np
np.import_array()
from libc.math cimport fmax, fmin


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