NAME = libETC1
SOURCES = etc1.cpp
SOURCES := $(foreach source, $(SOURCES), opengl/libs/ETC1/$(source))
CPPFLAGS += -Iopengl/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0

debian/out/$(NAME).so.0: $(SOURCES)
	mkdir --parents debian/out
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so
	dpkg-gensymbols -pandroid-libetc1 -v0 -e$@ -Odebian/android-libetc1.symbols