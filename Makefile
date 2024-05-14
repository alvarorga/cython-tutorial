all:
	make build-hello

build-hello: hello_world.pyx
	python3 setup_hello.py build_ext --inplace