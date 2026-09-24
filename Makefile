# ── Rogue ────────────────────────────────────────────────────────────────────
# A terminal roguelike written in C with ncurses + SDL2_mixer.

CC      := gcc
CFLAGS  := -Wall -O2
LDLIBS  := -lncursesw -lSDL2 -lSDL2_mixer

TARGET  := rogue
SRC     := src/main.c
DEPS    := $(wildcard src/*.c) src/head.h

.PHONY: all run clean

all: $(TARGET)

# main.c textually includes the other translation units, so a single
# invocation builds the whole game.
$(TARGET): $(DEPS)
	$(CC) $(CFLAGS) $(SRC) $(LDLIBS) -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET) *.o
