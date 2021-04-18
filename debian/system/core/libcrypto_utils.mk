NAME:= libcrypto_utils
SOURCES := android_pubkey.c
SOURCES := $(foreach source, $(SOURCES), system/core/libcrypto_utils/$(source))
CPPFLAGS += -Isystem/core/libcrypto_utils/include -Isystem/core/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
	-Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
	-L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
	-lcrypto -Wl,-z,defs

build: $(SOURCES)
	$(CC) $^ -o system/core/$(NAME).so.0  $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
