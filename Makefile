all : clean fmt build info

clean:
	moon clean

fmt:
	moon fmt

build:
	moon build

info:
	moon info 

.PHONY: all clean fmt build info
