NAME = libziparchive

SOURCES = \
  zip_archive.cc \
  zip_archive_stream_entry.cc \
  zip_writer.cc \

SOURCES := $(foreach source, $(SOURCES), system/core/libziparchive/$(source))
OBJECTS = $(SOURCES:.cc=.o)

CXXFLAGS += -std=gnu++17
CPPFLAGS += \
  -DZLIB_CONST \
  -D_FILE_OFFSET_BITS=64 \
  -I/usr/include/android \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -Isystem/core/liblog/include \
  -Isystem/core/libziparchive/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Wl,-soname,$(NAME).so.0 \
  -lbase \
  -llog \
  -lpthread \
  -lz \
  -shared

build: $(OBJECTS)
	$(CXX) $^ -o debian/out/system/core/$(NAME).so.0 $(LDFLAGS)
	cd debian/out/system/core && ln -s $(NAME).so.0 $(NAME).so

$(OBJECTS): %.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
