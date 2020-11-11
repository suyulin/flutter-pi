CC = cc
LD = cc
PKG_CONFIG = pkg-config
REAL_CFLAGS = -I./include $(shell ${PKG_CONFIG} --cflags gbm libdrm glesv2 egl) -DBUILD_TEXT_INPUT_PLUGIN -ggdb $(CFLAGS)
REAL_LDFLAGS = $(shell pkg-config --libs gbm libdrm glesv2 egl) -lrt -lflutter_engine -lpthread -ldl $(LDFLAGS)

SOURCES = src/flutter-pi.c src/platformchannel.c src/pluginregistry.c src/console_keyboard.c \
	src/plugins/services.c src/plugins/text_input.c \
	src/plugins/raw_keyboard.c
OBJECTS = $(patsubst src/%.c,out/obj/%.o,$(SOURCES))

all: out/flutter-pi

out/obj/%.o: src/%.c 
	@mkdir -p $(@D)
	$(CC) -c $(REAL_CFLAGS) $(REAL_LDFLAGS) $< -o $@

out/flutter-pi: $(OBJECTS)
	@mkdir -p $(@D)
	$(CC) $(REAL_CFLAGS) $(REAL_LDFLAGS) $(OBJECTS) -o out/flutter-pi

clean:
	@mkdir -p out
	rm -rf $(OBJECTS) out/flutter-pi out/obj/*
