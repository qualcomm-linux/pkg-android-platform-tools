NAME = etc1tool
SOURCES = etc1tool.cpp
SOURCES := $(foreach source, $(SOURCES), tools/etc1tool/$(source))
CPPFLAGS += -Iinclude
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lpng -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -lETC1

$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)