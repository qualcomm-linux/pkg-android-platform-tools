NAME = libsigchain

SOURCES = sigchain.cc
SOURCES := $(foreach source, $(SOURCES), sigchainlib/$(source))

CPPFLAGS += -Isigchainlib
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
