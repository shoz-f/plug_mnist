ifeq ($(MIX_APP_PATH),)
calling_from_make:
	mix compile
endif

WORK_HOME ?= C:/msys64/home/work
INCLUDE   = -I./src \
            -I$(WORK_HOME)/CImg-2.9.2 \
            -I$(WORK_HOME)/tensorflow_src \
            -I$(WORK_HOME)/tensorflow_src/tensorflow/lite/tools/make/downloads/flatbuffers/include
DEFINES   = -D__LITTLE_ENDIAN__ -DTFLITE_WITHOUT_XNNPACK
CXXFLAGS += -O3 -DNDEBUG -fPIC --std=c++11 -fext-numeric-literals $(INCLUDE) $(DEFINES)
LDFLAGS  += -L/usr/local/lib -static -lmman -ljpeg

TFL_LIB = $(WORK_HOME)/tensorflow_src/tensorflow/lite/tools/make/gen/windows_x86_64/lib/libtensorflow-lite.a

SRC=$(wildcard src/*.cc)
OBJ=$(addprefix obj/, $(notdir $(SRC:.cc=.o)))

all: obj priv install

install: priv/tfl_interp

obj/%.o: src/%.cc
	$(CXX) -c $(CXXFLAGS) -o $@ $<

priv/tfl_interp: $(OBJ)
	$(CXX) $^ $(TFL_LIB) $(LDFLAGS) -o $@

clean:
	rm -f priv/tfl_interp $(OBJ)

priv obj:
	mkdir -p $@

print-vars:
	@$(foreach v,$(.VARIABLES),$(info $v=$($v)))

.PHONY: all clean calling_from_make install print-vars
