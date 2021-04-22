NAME = libdexfile_support

SOURCES = libdexfile/external/dex_file_supp.cc
CPPFLAGS += \
  -DNO_DEXFILE_SUPPORT \
  -Ilibartbase \
  -Ilibdexfile \
  -Ilibdexfile/external/include \

CXXFLAGS += -std=gnu++17
LDFLAGS += \
  -shared \
  -Wl,-soname,$(NAME).so.0
LIBRARIES_FLAGS = \
  -ldl \
  -lpthread \

debian/out/$(NAME).so.0: $(SOURCES)
	$(CXX) -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ $(LIBRARIES_FLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so
