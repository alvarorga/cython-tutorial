all:
	make build-hello
	make build-array-ops
	make build-monte-carlo

build-hello: hello_world.pyx
	python3 setup_hello.py build_ext --inplace

build-array-ops: array_operations.pyx
	python3 setup_arrays.py build_ext --inplace

build-monte-carlo: monte_carlo.pyx
	python3 setup_monte_carlo.py build_ext --inplace