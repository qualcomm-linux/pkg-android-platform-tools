NAME = libdexfile_support

SOURCES = art/libdexfile/external/dex_file_supp.cc
CPPFLAGS += \
  -DNO_DEXFILE_SUPPORT \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/libdexfile/external/include \
  -I/usr/include/android \
  -Isystem/core/liblog/include \
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
