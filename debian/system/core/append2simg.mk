NAME = append2simg
SOURCES = append2simg.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))
CPPFLAGS += -I/usr/include/android \
            -Isystem/core/libsparse/include \
            -Isystem/core/include \
            -Isystem/core/libsparse/include \
            -std=gnu++17
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Wl,-rpath-link system/core \
           -Lsystem/core -lsparse

system/core/libsparse/$(NAME): $(SOURCES)
	$(CXX) $^ -o system/core/libsparse/$(NAME) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) system/core/libsparse/$(NAME)
