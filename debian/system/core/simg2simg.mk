NAME = simg2simg

SOURCES = simg2simg.cpp sparse_crc32.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))

CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/libsparse/include \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -fpermissive -std=gnu++17 \

LDFLAGS += -lz
STATIC_LIBS = \
  debian/out/system/core/libsparse.a \
  debian/out/system/core/libbase.a \
  debian/out/system/core/liblog.a \

# force GCC, clang fails on:
# libsparse/simg2simg.cpp:75:11: error: assigning to 'struct sparse_file **' from incompatible type 'void *'
#  out_s = calloc(sizeof(struct sparse_file*), files);

debian/out/system/core/$(NAME): $(SOURCES)
	mkdir --parents debian/out/system/core
	g++ -o $@ $^ $(CPPFLAGS) $(STATIC_LIBS) $(LDFLAGS)
