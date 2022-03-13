NAME = libsparse

SOURCES = \
  backed_block.cpp \
  output_file.cpp \
  sparse.cpp \
  sparse_crc32.cpp \
  sparse_err.cpp \
  sparse_read.cpp \

SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))
OBJECTS := $(SOURCES:.cpp=.o)

CXXFLAGS += -std=gnu++2a
CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/base/include \
  -Isystem/core/include \
  -Isystem/core/libsparse/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-soname,$(NAME).so.0 \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -lbase \
  -lz \
  -shared \

build: $(OBJECTS)
	mkdir -p debian/out/system/core
	$(CXX) $^ -o debian/out/system/core/$(NAME).so.0 $(LDFLAGS)
	cd debian/out/system/core && ln -sf $(NAME).so.0 $(NAME).so

$(OBJECTS): %.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
