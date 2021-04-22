NAME = dmtracedump
SOURCES = tracedump.cc
SOURCES := $(foreach source, $(SOURCES), art/tools/dmtracedump/$(source))
CPPFLAGS += -Iart/tools/dmtracedump -I/usr/include/android -Umips

debian/out/art/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
