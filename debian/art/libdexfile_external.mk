NAME = libdexfile_external

SOURCES = art/libdexfile/external/dex_file_ext.cc
CPPFLAGS += \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/libdexfile/external/include \
  -I/usr/include/android/nativehelper \
  -I/usr/include/android \
  -Umips \

CXXFLAGS += -std=gnu++17
LDFLAGS += \
  -shared \
  -Wl,-soname,$(NAME).so.0
LIBRARIES_FLAGS = \
  -ldl \
  -lpthread \

debian/out/art/$(NAME).so.0: $(SOURCES)
	$(CXX) -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ $(LIBRARIES_FLAGS)
	ln -s $(NAME).so.0 debian/out/art/$(NAME).so
