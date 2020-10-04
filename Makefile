DEFAULT_TARGETS ?= priv priv/tfl_interp.exe

C++ = g++

WORK_HOME ?= C:/msys64/home/work
INCLUDE   = -I./src \
            -I$(WORK_HOME)/CImg-2.9.2 \
            -I$(WORK_HOME)/tensorflow_src \
            -I$(WORK_HOME)/tensorflow_src/tensorflow/lite/tools/make/downloads/flatbuffers/include
DEFINES   = -D__LITTLE_ENDIAN__ -DTFLITE_WITHOUT_XNNPACK
CXXFLAGS  = -O3 -DNDEBUG -fPIC --std=c++11 -fext-numeric-literals -fopenmp $(INCLUDE) $(DEFINES)
LDFLAGS   = -L/usr/local/lib -static -lpthread -lm -lz -ldl -lmman -ljpeg -lgdi32 -lgomp

TFL_LIB = $(WORK_HOME)/tensorflow_src/tensorflow/lite/tools/make/gen/windows_x86_64/lib/libtensorflow-lite.a

SRC=$(wildcard src/*.cc)
OBJ=$(SRC:.cc=.o)

.PHONY: all clean

all: $(DEFAULT_TARGETS)

%.o: %.c
	$(C++) -c -o $@ $<

priv:
	mkdir -p priv

priv/tfl_interp.exe: $(OBJ)
	$(C++) $^ $(TFL_LIB) $(LDFLAGS) -o $@

clean:
	rm -f priv/ale src/*.o
