NAME = libETC1
SOURCES = etc1.cpp
SOURCES := $(foreach source, $(SOURCES), frameworks/native/opengl/libs/ETC1/$(source))
CPPFLAGS += -Iframeworks/native/opengl/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0

debian/out/frameworks/native/$(NAME).so.0: $(SOURCES)
	mkdir --parents debian/out/frameworks/native
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/frameworks/native/$(NAME).so
