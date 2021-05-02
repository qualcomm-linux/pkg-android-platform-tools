NAME = simg2simg
SOURCES = simg2simg.cpp sparse_crc32.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))
CPPFLAGS += -I/usr/include/android \
            -Isystem/core/libsparse/include \
            -Isystem/core/include \
            -fpermissive -std=gnu++17
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Wl,-rpath-link system/core \
           -Lsystem/core -lsparse -lz -lbase

# force GCC, clang fails on:
# libsparse/simg2simg.cpp:75:11: error: assigning to 'struct sparse_file **' from incompatible type 'void *'
#  out_s = calloc(sizeof(struct sparse_file*), files);

system/core/libsparse/$(NAME): $(SOURCES)
	g++ $^ -o system/core/libsparse/$(NAME) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) system/core/libsparse/$(NAME)
