NAME = etc1tool
SOURCES = etc1tool.cpp
SOURCES := $(foreach source, $(SOURCES), development/tools/etc1tool/$(source))
CPPFLAGS += -Idevelopment/include -I/usr/include/android
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lpng -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -lETC1

development/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) development/$(NAME)
