NAME = libETC1
SOURCES_libETC1 = etc1.cpp
OBJECTS = $(SOURCES_libETC1:.cpp=.o)
SOURCES := $(foreach source, $(SOURCES_libETC1), frameworks/native/opengl/libs/ETC1/$(source))
CPPFLAGS += -Iframeworks/native/opengl/include

debian/out/frameworks/native/$(NAME).a: $(SOURCES)
	mkdir --parents debian/out/frameworks/native
	$(CXX) -c $^ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ar -rcs $@ $(OBJECTS)
