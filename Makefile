all : clean fmt build info

clean:
	moon clean

fmt:
	moon fmt

build:
	moon build
	moon build -C examples/counter

info:
	moon info 

.PHONY: all clean fmt build info
