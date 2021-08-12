;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12439 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _setupbug
	.globl _setupship
	.globl _movegamecharacter
	.globl _performantdelay
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _spritesize
	.globl _GameSprites
	.globl _bug
	.globl _ship
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ship::
	.ds 8
_bug::
	.ds 8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_GameSprites::
	.ds 128
_spritesize::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:10: void performantdelay(UINT8 numloops){
;	---------------------------------
; Function performantdelay
; ---------------------------------
_performantdelay::
;main.c:12: for( i = 0; i < numloops;i++){
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:13: wait_vbl_done();
	call	_wait_vbl_done
;main.c:12: for( i = 0; i < numloops;i++){
	inc	c
;main.c:17: }
	jr	00103$
;main.c:19: void movegamecharacter(struct GameCharacter* character, UINT8 x, UINT8 y){
;	---------------------------------
; Function movegamecharacter
; ---------------------------------
_movegamecharacter::
	add	sp, #-3
;main.c:20: move_sprite(character->spritids[0],x,y);
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:21: move_sprite(character->spritids[1],x+spritesize,y);
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_spritesize
	add	a, (hl)
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	c, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(bc), a
	inc	bc
;main.c:22: move_sprite(character->spritids[2],x,y+spritesize);
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_spritesize
	add	a, (hl)
	ld	c, a
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
;main.c:23: move_sprite(character->spritids[3],x+spritesize,y+spritesize);
	ld	a, (hl-)
	ld	(bc), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_spritesize
	add	a, (hl)
	ld	b, a
	ldhl	sp,	#1
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_spritesize
	add	a, (hl)
	ld	c, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:23: move_sprite(character->spritids[3],x+spritesize,y+spritesize);
;main.c:25: }
	add	sp, #3
	ret
;main.c:27: void setupship(){
;	---------------------------------
; Function setupship
; ---------------------------------
_setupship::
;main.c:28: ship.x = 80;
	ld	bc, #_ship+0
	ld	hl, #(_ship + 4)
	ld	(hl), #0x50
;main.c:29: ship.y = 130;
	ld	hl, #(_ship + 5)
	ld	(hl), #0x82
;main.c:30: ship.width = 16;
	ld	hl, #(_ship + 6)
	ld	(hl), #0x10
;main.c:31: ship.height = 16;
	ld	hl, #(_ship + 7)
	ld	(hl), #0x10
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:34: ship.spritids[0] =0;
	xor	a, a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
;main.c:36: ship.spritids[1] =1;
	ld	hl, #(_ship + 1)
	ld	(hl), #0x01
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;main.c:38: ship.spritids[2] =2;
	ld	hl, #(_ship + 2)
	ld	(hl), #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;main.c:40: ship.spritids[3] =3;
	ld	hl, #(_ship + 3)
	ld	(hl), #0x03
;main.c:42: movegamecharacter(&ship,ship.x,ship.y);
	ld	a, (#(_ship + 5) + 0)
	ld	hl, #(_ship + 4)
	ld	h, (hl)
;	spillPairReg hl
	push	af
	inc	sp
	push	hl
	inc	sp
	push	bc
	call	_movegamecharacter
	add	sp, #4
;main.c:44: }
	ret
;main.c:46: void setupbug(){
;	---------------------------------
; Function setupbug
; ---------------------------------
_setupbug::
;main.c:47: bug.x = 30;
	ld	hl, #(_bug + 4)
	ld	(hl), #0x1e
;main.c:48: bug.y = 0;
	ld	bc, #_bug + 5
	xor	a, a
	ld	(bc), a
;main.c:49: bug.width = 16;
	ld	hl, #(_bug + 6)
	ld	(hl), #0x10
;main.c:50: bug.height = 16;
	ld	hl, #(_bug + 7)
	ld	(hl), #0x10
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x04
;main.c:53: bug.spritids[0] =4;
	ld	hl, #_bug
	ld	(hl), #0x04
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x05
;main.c:55: bug.spritids[1] =5;
	ld	hl, #(_bug + 1)
	ld	(hl), #0x05
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x06
;main.c:57: bug.spritids[2] =6;
	ld	hl, #(_bug + 2)
	ld	(hl), #0x06
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x07
;main.c:59: bug.spritids[3] =7;
	ld	hl, #(_bug + 3)
	ld	(hl), #0x07
;main.c:61: movegamecharacter(&bug,bug.x,bug.y);
	ld	a, (bc)
	ld	b, a
	ld	a, (#(_bug + 4) + 0)
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	de, #_bug
	push	de
	call	_movegamecharacter
	add	sp, #4
;main.c:63: }
	ret
;main.c:67: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:68: set_sprite_data(0,8,GameSprites);
	ld	de, #_GameSprites
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:69: setupship();
	call	_setupship
;main.c:70: setupbug();
	call	_setupbug
;main.c:72: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:73: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:75: while(1){
00108$:
;main.c:76: if(joypad() & J_LEFT){
	call	_joypad
	bit	1, e
	jr	Z, 00102$
;main.c:77: ship.x-=2;
	ld	de, #_ship + 4
	ld	a, (de)
	dec	a
	dec	a
	ld	(de), a
;main.c:78: movegamecharacter(&ship, ship.x, ship.y);
	ld	hl, #_ship + 5
	ld	b, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	de, #_ship
	push	de
	call	_movegamecharacter
	add	sp, #4
00102$:
;main.c:80: if(joypad() & J_RIGHT){
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;main.c:81: ship.x+=2;
	ld	de, #_ship + 4
	ld	a, (de)
	add	a, #0x02
	ld	(de), a
;main.c:82: movegamecharacter(&ship, ship.x, ship.y);
	ld	hl, #_ship + 5
	ld	b, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	de, #_ship
	push	de
	call	_movegamecharacter
	add	sp, #4
00104$:
;main.c:84: bug.y +=5;
	ld	bc, #_bug + 5
	ld	a, (bc)
	add	a, #0x05
	ld	(bc), a
;main.c:86: if(bug.y>= 144){
	ld	a, (bc)
;main.c:88: bug.x = ship.x;
;main.c:86: if(bug.y>= 144){
	sub	a, #0x90
	jr	C, 00106$
;main.c:87: bug.y=0;
	xor	a, a
	ld	(bc), a
;main.c:88: bug.x = ship.x;
	ld	a, (#(_ship + 4) + 0)
	ld	(#(_bug + 4)),a
00106$:
;main.c:91: movegamecharacter(&bug,bug.x, bug.y);
	ld	a, (bc)
	ld	hl, #(_bug + 4)
	ld	b, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	de, #_bug
	push	de
	call	_movegamecharacter
	add	sp, #4
;main.c:93: performantdelay(5);
	ld	a, #0x05
	push	af
	inc	sp
	call	_performantdelay
	inc	sp
;main.c:95: }
	jr	00108$
	.area _CODE
	.area _INITIALIZER
__xinit__GameSprites:
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x01	; 1
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x03	; 3
	.db #0xe4	; 228
	.db #0x67	; 103	'g'
	.db #0x99	; 153
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x41	; 65	'A'
	.db #0xc0	; 192
	.db #0x27	; 39
	.db #0xe6	; 230
	.db #0x99	; 153
	.db #0x7f	; 127
	.db #0x81	; 129
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x0f	; 15
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x08	; 8
	.db #0x01	; 1
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xfc	; 252
	.db #0x82	; 130
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x10	; 16
	.db #0x80	; 128
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x07	; 7
	.db #0x47	; 71	'G'
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xe0	; 224
	.db #0xe2	; 226
	.db #0xf0	; 240
	.db #0xfc	; 252
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x0d	; 13
	.db #0x1d	; 29
	.db #0x3d	; 61
	.db #0x0d	; 13
	.db #0x47	; 71	'G'
	.db #0x0f	; 15
	.db #0x43	; 67	'C'
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0xb8	; 184
	.db #0xbc	; 188
	.db #0xb0	; 176
	.db #0xe2	; 226
	.db #0xf0	; 240
	.db #0xc2	; 194
	.db #0xe0	; 224
	.db #0x01	; 1
	.db #0xc0	; 192
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
__xinit__spritesize:
	.db #0x08	; 8
	.area _CABS (ABS)
