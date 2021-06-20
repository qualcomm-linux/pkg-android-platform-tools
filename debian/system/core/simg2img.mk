NAME = simg2img

SOURCES = simg2img.cpp sparse_crc32.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))

CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/libsparse/include \
  -Isystem/core/include \
  -std=gnu++17 \

LDFLAGS += -lz
STATIC_LIBS = \
  debian/out/system/core/libsparse.a \
  debian/out/system/core/libbase.a \
  debian/out/system/core/liblog.a \

debian/out/system/core/$(NAME): $(SOURCES)
	mkdir --parents debian/out/system/core
	$(CXX) -o $@ $^ $(CPPFLAGS) $(STATIC_LIBS) $(LDFLAGS)
