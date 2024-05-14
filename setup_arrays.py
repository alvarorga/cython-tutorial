import sys
from setuptools import Extension, setup
from Cython.Build import cythonize
import numpy


# Compile instructions: Run:
# > python setup_*.py build_ext --inplace


if sys.platform == "win32":
    # We assume Microsoft Visual C/C++ compiler
    extra_compile_args = ["/O2", "/fp:fast", "/std:c++17"]
else:
    # We assume GCC or other compilers with compatible command line
    extra_compile_args = ["-O3", "-ffast-math", "-std=c++17"]

ext_modules = [
    Extension(
        "array_operations",
        ["array_operations.pyx"],
        language="c++",
        extra_compile_args=extra_compile_args,
        define_macros=[('NPY_NO_DEPRECATED_API', 'NPY_1_7_API_VERSION')]
    )
]

debug = False
if not debug:
    directives = {
        "language_level": "3",  # We assume Python 3 code
        "boundscheck": False,  # Do not check array access
        "wraparound": False,  # a[-1] does not work
        "embedsignature": False,  # Do not save typing / docstring
        "always_allow_keywords": False,  # Faster calling conventions
        "cdivision": True,  # No exception on zero denominator
        "initializedcheck": False,  # We take care of initializing cdef classes and memory views
    }
else:
    directives = {
        "language_level": "3",  # We assume Python 3 code
        "boundscheck": True,  # Do not check array access
        "wraparound": True,  # a[-1] does not work
        "embedsignature": False,  # Do not save typing / docstring
        "always_allow_keywords": False,  # Faster calling conventions
        "cdivision": False,  # No exception on zero denominator
        "initializedcheck": True,  # We take care of initializing cdef classes and memory views
    }

setup(
    name='array_operations.pyx',
    ext_modules=cythonize(
        ext_modules,
        language_level="3",
        annotate=False,
        compiler_directives=directives
    ),
    include_dirs=[numpy.get_include()]
)