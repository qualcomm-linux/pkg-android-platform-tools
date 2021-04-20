NAME = ziptime
SOURCES = ZipTime.cpp ZipEntry.cpp ZipFile.cpp
SOURCES := $(foreach source, $(SOURCES), build/make/tools/ziptime/$(source))
CPPFLAGS += -I/usr/include/android

build/make/$(NAME): $(SOURCES)
	$(CXX) $^ -o build/make/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) build/make/$(NAME)
