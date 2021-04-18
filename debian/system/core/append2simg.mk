NAME = append2simg
SOURCES = append2simg.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))
CPPFLAGS += -Isystem/core/libsparse/include -Isystem/core/include -std=gnu++17
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Wl,-rpath-link=. \
           -Lsystem/core -lsparse

build: $(SOURCES)
	$(CXX) $^ -o system/core/libsparse/$(NAME) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) system/core/libsparse/$(NAME)
