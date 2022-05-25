NAME:= libcrypto_utils

SOURCES = system/core/libcrypto_utils/android_pubkey.c
OBJECTS = $(SOURCES:.c=.o)

CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/include \
  -Isystem/core/libcrypto_utils/include \

debian/out/system/core/$(NAME).a: $(OBJECTS)
	ar -rcs $@ $^

$(OBJECTS): %.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS) $(CPPFLAGS)
