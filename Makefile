
export CC := gcc
export MIX_TARGET := rpi3

all:
	mix deps.get
	mix compile
	mix firmware
