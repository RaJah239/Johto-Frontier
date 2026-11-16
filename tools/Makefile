.PHONY: all clean

CC := gcc
CXX := g++
CFLAGS := -O3 -flto -std=c11 -Wall -Wextra -pedantic

tools := \
	bpp2png \
	lzpcompress \
	gfx \
	png_dimensions \
	pokemon_animation \
	pokemon_animation_graphics \
	scan_includes \
	stadium

all: $(tools)
	@:

clean:
	$(RM) $(tools) lzcomp

gfx: common.h
png_dimensions: common.h
pokemon_animation: common.h
pokemon_animation_graphics: common.h
scan_includes: common.h
stadium: common.h

bpp2png: bpp2png.c lodepng/lodepng.c common.h lodepng/lodepng.h
	$(CC) $(CFLAGS) -o $@ bpp2png.c lodepng/lodepng.c

lzpcompress: lzpcompress.cpp
	$(CXX) -O3 -std=c++20 -Wall -Wextra -o $@ $<

%: %.c
	$(CC) $(CFLAGS) -o $@ $<
