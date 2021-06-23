NAME = libdexfile_support

SOURCES = art/libdexfile/external/dex_file_supp.cc
OBJECTS = $(SOURCES:.cc=.o)

CPPFLAGS += \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/libdexfile/external/include \
  -I/usr/include/android \
  -Isystem/core/liblog/include \
  -Isystem/core/base/include \
  -Umips \

CXXFLAGS += -std=gnu++17

debian/out/art/$(NAME).a: $(OBJECTS)
	mkdir --parents debian/out/art
	ar -rcs $@ $^

$(OBJECTS): %.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
