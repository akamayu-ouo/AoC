#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <string.h>

static const uint32_t Tiles[5] = {
	0x0000001e, //0b0001 1110
	0x00081c08, //0b0000 1000 0b0001 1100 0b0000 1000
	0x0004041c, //0b0000 0100 0b0000 0100 0b0001 1100
	0x10101010, //0b0001 0000 0b0001 0000 0b0001 0000 0b0001 0000
	0x00001818, //0b0001 1000 0b0001 1000
};

static const int TileHeights[5] = {1,3,3,4,2};

static const int BoardBufSize = 32768;

struct Board {
	unsigned char* data;
	int h;
};

struct Str {
	char* data;
	int l;
};

struct WrapCounter {
	int val;
	int p;
};

struct UWrapCounter {
	uint32_t val;
	uint32_t sf;
};


static inline int blowTile(uint32_t* tile, int dir) {
	if (dir) {
		if(0x40404040 & *tile) return 0;
		*tile <<= 1;
		return 1;
	} else {
		if(0x01010101 & *tile) return 0;
		*tile >>= 1;
		return 1;
	}
}

int hit(const struct Board b, int bp, uint32_t tile) {
	switch(b.h - bp) {
		break; case 1:{
			unsigned char* t = (unsigned char*)(&tile);
			return (b.data[bp+0] & t[0])
			     | (b.data[0]    & t[1])
			     | (b.data[1]    & t[2])
			     | (b.data[2]    & t[3]);
		}
		break; case 2:{
			unsigned char* t = (unsigned char*)(&tile);
			return (b.data[bp+0] & t[0])
			     | (b.data[bp+1] & t[1])
			     | (b.data[0]    & t[2])
			     | (b.data[1]    & t[3]);
		}
		break; case 3:{
			unsigned char* t = (unsigned char*)(&tile);
			return (b.data[bp+0] & t[0])
			     | (b.data[bp+1] & t[1])
			     | (b.data[bp+2] & t[2])
			     | (b.data[0]    & t[3]);
		}
		break; default:
			return (*(uint32_t*)(b.data+bp)) & tile;
		break;
	}
}

void set(struct Board b, int bp, uint32_t tile, int tileh) {
	switch(b.h - bp - tileh) {
		break; case -3:{
			unsigned char* t = (unsigned char*)(&tile);
			b.data[bp] |= t[0];
			b.data[0] |= t[1];
			b.data[1] |= t[2];
			b.data[2] |= t[3];
		}
		break; case -2:{
			unsigned char* t = (unsigned char*)(&tile);
			b.data[bp]   |= t[0];
			b.data[bp+1] |= t[1];
			b.data[0]    |= t[2];
			b.data[1]    |= t[3];
		}
		break; case -1:{
			unsigned char* t = (unsigned char*)(&tile);
			b.data[bp]   |= t[0];
			b.data[bp+1] |= t[1];
			b.data[bp+2] |= t[2];
			b.data[0]    |= t[3];
		}
		break; default:
			(*(uint32_t*)(b.data+bp)) |= tile;
		break;
	}
}

static inline void clear(struct Board b, int bp) {
	b.data[bp] = 0;
}

static inline struct Str readline() {
	char* buf = calloc(10240, sizeof(char));
	scanf("%s", buf);
	struct Str line = { .data=buf, .l=strlen(buf) };
	return line;
}

static inline struct Board makeBoard(int h){
	struct Board b = {.data = calloc(h+16, sizeof(unsigned char)), .h = h};
	return b;
}

static inline void shiftCounter(struct WrapCounter* wc, int amt) {
	//if(amt < 0) amt += wc->p;
	if ((wc->val += amt) >= wc-> p) wc->val -= wc->p;
	//wc->val = (wc->val + ((amt + wc->p) % wc->p)) % (wc->p);
}

static inline void addUCounter(struct UWrapCounter* uc, uint32_t amt) {
	uc->val += amt << uc->sf;
}
static inline void subUCounter(struct UWrapCounter* uc, uint32_t amt) {
	uc->val -= amt << uc->sf;
}
static inline uint32_t UCounterVal(struct UWrapCounter* uc) {
	return uc->val >> uc->sf;
}

void show (const struct Board b, int w) {
	for(int i = b.h-1; i >= 0 ; --i) {
		for(int j = w-1; j >=0 ; --j) {
			printf("%c" , ((b.data[i] >> j)&0x1) ? '#': '.');
		}
		putchar('\n');
	}
}

int main (void) {
	uint64_t NTile = 100000000;//1000000000000;
	uint64_t maxheight = 0;

	struct Str directions = readline();
	struct Board board = makeBoard(BoardBufSize);

	struct WrapCounter dp = {.val = 0, .p = directions.l};
	struct WrapCounter tp = {.val = 0, .p = sizeof(Tiles)/sizeof(Tiles[0])};

	board.data[board.h-1] = -1;

	while(NTile--) {
		uint32_t tile = Tiles[tp.val];
		int tileh = TileHeights[tp.val];
		shiftCounter(&tp, 1);

		struct UWrapCounter bp = { .val = ((uint32_t)maxheight % board.h)<<17U, .sf = 17U };
		for(int i = 0; i < 7; ++i){
			clear(board, UCounterVal(&bp));
			addUCounter(&bp, 1);
		}
		subUCounter(&bp, 4);
		int dh = 7 - 4 + 1 + tileh;

		do {
			int dir = directions.data[dp.val] == '<';
			shiftCounter(&dp, 1);

			if(blowTile(&tile, dir) && hit(board, UCounterVal(&bp), tile))
				blowTile(&tile, !dir);

			subUCounter(&bp, 1); dh -= 1;
		} while (!hit(board, UCounterVal(&bp), tile));

		addUCounter(&bp, 1);
		set(board, UCounterVal(&bp), tile, tileh);
		addUCounter(&bp, tileh);

		if(dh > 0) maxheight += dh;
	}
	//show(board, 7);
	printf("%" PRIu64 "\n", maxheight);
	free(directions.data);
	free(board.data);
	return 0;
}
