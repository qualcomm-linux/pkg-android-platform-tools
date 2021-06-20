NAME:= libcrypto_utils

SOURCES = system/core/libcrypto_utils/android_pubkey.c
OBJECTS = $(SOURCES:.c=.o)

CPPFLAGS += -I/usr/include/android \
            -Isystem/core/libcrypto_utils/include \
            -Isystem/core/include \
            -Iexternal/boringssl/include \

debian/out/system/core/$(NAME).a: $(OBJECTS)
	mkdir --parents debian/out/system/core
	ar -rcs $@ $^

$(OBJECTS): %.o: %.c
	$(CC) -c -o $@ $< $(CPPFLAGS)
