NAME = dmtracedump
SOURCES = tracedump.cc
SOURCES := $(foreach source, $(SOURCES), tools/dmtracedump/$(source))
CPPFLAGS += -Itools/dmtracedump

debian/out/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
