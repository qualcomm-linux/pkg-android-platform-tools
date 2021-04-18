NAME = libziparchive
SOURCES = zip_archive.cc \
          zip_archive_stream_entry.cc\
          zip_writer.cc
SOURCES := $(foreach source, $(SOURCES), system/core/libziparchive/$(source))
CXXFLAGS += -std=gnu++17
CPPFLAGS += -DZLIB_CONST -D_FILE_OFFSET_BITS=64 \
            -Isystem/core/include -Isystem/core/base/include -Isystem/core/libziparchive/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lz -Lsystem/core -llog -lbase

build: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
