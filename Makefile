all : clean fmt build info

clean:
	NEW_MOON=1 moon clean

fmt:
	NEW_MOON=1 moon fmt

build:
	NEW_MOON=1 moon build
	NEW_MOON=1 moon build -C examples/counter

info:
	NEW_MOON=1 moon info 

.PHONY: all clean fmt build info
