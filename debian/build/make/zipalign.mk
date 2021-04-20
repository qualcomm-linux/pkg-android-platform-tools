NAME = zipalign
SOURCES = ZipAlign.cpp ZipEntry.cpp ZipFile.cpp
SOURCES := $(foreach source, $(SOURCES), build/make/tools/zipalign/$(source))
CPPFLAGS += -I/usr/include/android
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lpthread -lzopfli -lz \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lutils -llog -landroidfw -lbacktrace -lziparchive

build/make/$(NAME): $(SOURCES)
	$(CXX) $^ -o build/make/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) build/make/$(NAME)
