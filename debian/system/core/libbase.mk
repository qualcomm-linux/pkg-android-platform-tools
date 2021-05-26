NAME = libbase
SOURCES = \
          abi_compatibility.cpp \
          chrono_utils.cpp \
          cmsg.cpp \
          file.cpp \
          liblog_symbols.cpp \
          logging.cpp \
          mapped_file.cpp \
          parsebool.cpp \
          parsenetaddress.cpp \
          process.cpp \
          properties.cpp \
          stringprintf.cpp \
          strings.cpp \
          threads.cpp \
          test_utils.cpp \
          \
          errors_unix.cpp

SOURCES := $(foreach source, $(SOURCES), system/core/base/$(source))
CXXFLAGS += -std=gnu++17 -D_FILE_OFFSET_BITS=64
CPPFLAGS += -I/usr/include/android -Isystem/core/include -Isystem/core/base/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Lsystem/core -llog

system/core/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
