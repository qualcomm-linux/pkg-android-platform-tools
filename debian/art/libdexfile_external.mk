NAME = libdexfile_external

SOURCES = art/libdexfile/external/dex_file_ext.cc
OBJECTS = $(SOURCES:.cc=.o)
CPPFLAGS += \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/libdexfile/external/include \
  -Ilibnativehelper/include_jni \
  -I/usr/include/android \
  -Isystem/core/base/include \
  -Umips \

CXXFLAGS += -std=gnu++17

debian/out/art/$(NAME).a: $(OBJECTS)
	mkdir --parents debian/out/art
	ar -rcs $@ $^

$(OBJECTS): %.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
