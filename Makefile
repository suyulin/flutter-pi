REAL_CFLAGS = -I./include $(shell pkg-config --cflags gbm libdrm glesv2 egl    ) \
	-O0 -ggdb \
	$(CFLAGS)

REAL_LDFLAGS = \
	$(shell pkg-config --libs gbm libdrm glesv2 egl  ) \
	-lrt \
	-lpthread \
	-ldl \
	-lm \
	$(LDFLAGS)

SOURCES = src/flutter-pi.c \
	src/plugins/services.c \
	src/plugins/text_input.c \
	src/plugins/raw_keyboard.c \

OBJECTS = $(patsubst src/%.c,out/obj/%.o,$(SOURCES))

all: out/flutter-pi

out/obj/%.o: src/%.c 
	@mkdir -p $(@D)
	$(CC) -c $(REAL_CFLAGS) $< -o $@

out/flutter-pi: $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $(REAL_CFLAGS) $(OBJECTS) $(REAL_LDFLAGS) -o out/flutter-pi

clean:
	@mkdir -p out
	rm -rf $(OBJECTS) out/flutter-pi out/obj/*
