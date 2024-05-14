all:
	make build-hello
	make build-array-ops

build-hello: hello_world.pyx
	python3 setup_hello.py build_ext --inplace

build-array-ops: array_operations.pyx
	python3 setup_arrays.py build_ext --inplace