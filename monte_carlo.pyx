import numpy as np
cimport numpy as np
cimport cython
from libc.math cimport log, fabs


# Import random number generators from std::random.
cdef extern from "<random>" namespace "std" nogil:
    cdef cppclass minstd_rand nogil:
        minstd_rand()
        minstd_rand(unsigned int seed)

    cdef cppclass mt19937_64 nogil:
        mt19937_64()
        mt19937_64(np.uint64_t seed)

    cdef cppclass uniform_real_distribution[T] nogil:
        uniform_real_distribution()
        uniform_real_distribution(T a, T b)
        T operator()(minstd_rand gen)
        T operator()(mt19937_64 gen)

    cdef cppclass uniform_int_distribution[T] nogil:
        uniform_int_distribution()
        uniform_int_distribution(T a, T b)
        T operator()(minstd_rand gen)
        T operator()(mt19937_64 gen)


def compute_pi_using_monte_carlo(unsigned int n_samples):
    rng = np.random.default_rng()
    seed = rng.integers(0, 0xfffffff, dtype=np.uint)
    pi = _compute_pi(n_samples, seed)
    return pi


cdef double _compute_pi(int n_samples, unsigned int seed):
    cdef:
        Py_ssize_t i
        int counts=0
        double pi=0.0

        # Random number generator and distribution where to draw numbers.
        mt19937_64 generator = mt19937_64(seed)
        uniform_real_distribution[float] dist_r = uniform_real_distribution[float](0.0,1.0)

    for i in range(n_samples):
        x = dist_r(generator)
        y = dist_r(generator)
        if (x * x + y * y) < 1.0:
            counts += 1

    pi = 4.0 * counts / n_samples
    return pi