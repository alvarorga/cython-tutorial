# Cython tutorial

Simple scripts and examples to learn Cython

## Cython documentation

You can find the documentation of Cython [here](https://docs.cython.org/en/latest/)

## Installation

We recommend to run this tutorial in a clean Python environment. For example:

`conda create -n cython_tutorial python=3.11 numpy cython`

To activate the environment, run:

`conda activate cython_tutorial`


## Compilation of a Cython script

You need to create a `setup_*.py` script with the instructions for compilations inside. See `setup_hello.py` for a simple example. Once this is created, compile the Cython script by running:

`python setup_hello.py build_ext --inplace`

You can call the methods defined inside the `.pyx` file as if they came from a Python module.
