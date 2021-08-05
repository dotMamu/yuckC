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
	.globl _jump
	.globl _wouldhitsurface
	.globl _performantdelay
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _floorYposition
	.globl _gravity
	.globl _yuckChar
	.globl _currentspeedY
	.globl _jumping
	.globl _playerlocation
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_playerlocation::
	.ds 2
_jumping::
	.ds 1
_currentspeedY::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_yuckChar::
	.ds 176
_gravity::
	.ds 1
_floorYposition::
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
;main.c:12: void performantdelay(UINT8 numloops){
;	---------------------------------
; Function performantdelay
; ---------------------------------
_performantdelay::
;main.c:14: for( i = 0; i < numloops;i++){
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:15: wait_vbl_done();
	call	_wait_vbl_done
;main.c:14: for( i = 0; i < numloops;i++){
	inc	c
;main.c:19: }
	jr	00103$
;main.c:21: INT8 wouldhitsurface(UINT8 projectedYposition){
;	---------------------------------
; Function wouldhitsurface
; ---------------------------------
_wouldhitsurface::
;main.c:22: if(projectedYposition>= floorYposition){
	ldhl	sp,	#2
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_floorYposition
	sub	a, (hl)
	jr	C, 00102$
;main.c:23: return floorYposition;
;setupPair	HL
	ld	e, (hl)
	ret
00102$:
;main.c:25: return -1;
	ld	e, #0xff
;main.c:26: }
	ret
;main.c:28: void jump(UINT8 spriteid, UINT8 spritelocation[2]){
;	---------------------------------
; Function jump
; ---------------------------------
_jump::
	dec	sp
	dec	sp
;main.c:31: if(jumping ==0 ){
;setupPair	HL
	ld	hl, #_jumping
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;main.c:32: jumping = 1;
;setupPair	HL
	ld	(hl), #0x01
;main.c:33: currentspeedY = 10;
;setupPair	HL
	ld	hl, #_currentspeedY
	ld	(hl), #0x0a
00102$:
;main.c:37: currentspeedY = currentspeedY + gravity;
;setupPair	HL
	ld	a, (#_currentspeedY)
;setupPair	HL
	ld	hl, #_gravity
	add	a, (hl)
;setupPair	HL
	ld	(#_currentspeedY),a
;main.c:39: spritelocation[1] = spritelocation[1] - currentspeedY;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
;setupPair	HL
	ld	hl, #_currentspeedY
	sub	a, (hl)
	ld	(bc), a
;main.c:41: possiblesurfaceY = wouldhitsurface(spritelocation[1]);
	push	bc
	push	af
	inc	sp
	call	_wouldhitsurface
	inc	sp
	pop	bc
	ldhl	sp,	#0
	ld	(hl), e
;main.c:45: set_sprite_tile(spriteid,2);
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#1
;main.c:43: if(possiblesurfaceY > -1){
	ld	(hl-), a
	ld	e, (hl)
	ld	a,#0xff
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00122$
	bit	7, d
	jr	NZ, 00123$
	cp	a, a
	jr	00123$
00122$:
	bit	7, d
	jr	Z, 00123$
	scf
00123$:
	jr	NC, 00104$
;main.c:44: jumping = 0;
;setupPair	HL
	ld	hl, #_jumping
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), #0x02
;main.c:46: move_sprite(spriteid,spritelocation[0],possiblesurfaceY);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:46: move_sprite(spriteid,spritelocation[0],possiblesurfaceY);
	jr	00110$
00104$:
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), #0x01
;main.c:49: move_sprite(spriteid,spritelocation[0],spritelocation[1]);
	ld	a, (bc)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:49: move_sprite(spriteid,spritelocation[0],spritelocation[1]);
00110$:
;main.c:55: }
	inc	sp
	inc	sp
	ret
;main.c:57: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;main.c:59: UINT8 currentSpriteIndex = 0;
	ld	c, #0x00
;main.c:61: set_sprite_data(0,10,yuckChar);
	ld	de, #_yuckChar
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:63: playerlocation[0] = 10;
	ld	hl, #_playerlocation
	ld	(hl), #0x0a
;main.c:64: playerlocation[1] = 100;
	ld	hl, #(_playerlocation + 1)
	ld	(hl), #0x64
;main.c:65: jumping = 0;
;setupPair	HL
	ld	hl, #_jumping
	ld	(hl), #0x00
;main.c:67: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	a, (#(_playerlocation + 1) + 0)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_playerlocation
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;main.c:69: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:70: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:72: while(1){
00137$:
;main.c:74: if(joypad() & J_LEFT){
	call	_joypad
	bit	1, e
	jr	Z, 00108$
;main.c:75: playerlocation[0] = playerlocation[0] -2;
	ld	a, (#_playerlocation + 0)
	dec	a
	dec	a
	ld	(#_playerlocation),a
;main.c:76: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #(_playerlocation + 1)
	ld	b, (hl)
	ld	e, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), e
;main.c:77: if (currentSpriteIndex==0){
	ld	a, c
	or	a, a
	jr	NZ, 00105$
;main.c:78: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:79: set_sprite_tile(0,currentSpriteIndex);
	jr	00108$
00105$:
;main.c:81: }else if (currentSpriteIndex==2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00102$
;main.c:83: currentSpriteIndex = 3;
	ld	c, #0x03
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x03
;main.c:84: set_sprite_tile(0,currentSpriteIndex);
	jr	00108$
00102$:
;main.c:86: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:87: set_sprite_tile(0,currentSpriteIndex);
00108$:
;main.c:92: if(joypad() & J_RIGHT){
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00116$
;main.c:93: playerlocation[0] = playerlocation[0] +2;
	ld	a, (#_playerlocation + 0)
	add	a, #0x02
	ld	(#_playerlocation),a
;main.c:94: move_sprite(0,playerlocation[0],playerlocation[1]);
	ld	hl, #(_playerlocation + 1)
	ld	b, (hl)
	ld	e, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), e
;main.c:95: if (currentSpriteIndex==0){
	ld	a, c
	or	a, a
	jr	NZ, 00113$
;main.c:96: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:97: set_sprite_tile(0,currentSpriteIndex);
	jr	00116$
00113$:
;main.c:99: }else if (currentSpriteIndex==2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00110$
;main.c:101: currentSpriteIndex = 3;
	ld	c, #0x03
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x03
;main.c:102: set_sprite_tile(0,currentSpriteIndex);
	jr	00116$
00110$:
;main.c:104: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:105: set_sprite_tile(0,currentSpriteIndex);
00116$:
;main.c:110: if(joypad() & J_UP){
	call	_joypad
	bit	2, e
	jr	Z, 00124$
;main.c:111: playerlocation[1] = playerlocation[1] -2;
	ld	a, (#(_playerlocation + 1) + 0)
	dec	a
	dec	a
	ld	(#(_playerlocation + 1)),a
;main.c:112: move_sprite(0,playerlocation[0],playerlocation[1]);
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_playerlocation
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;main.c:113: if (currentSpriteIndex==0){
	ld	a, c
	or	a, a
	jr	NZ, 00121$
;main.c:114: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:115: set_sprite_tile(0,currentSpriteIndex);
	jr	00124$
00121$:
;main.c:117: }else if (currentSpriteIndex==2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00118$
;main.c:119: currentSpriteIndex = 3;
	ld	c, #0x03
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x03
;main.c:120: set_sprite_tile(0,currentSpriteIndex);
	jr	00124$
00118$:
;main.c:122: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:123: set_sprite_tile(0,currentSpriteIndex);
00124$:
;main.c:127: if(joypad() & J_DOWN){
	call	_joypad
	bit	3, e
	jr	Z, 00132$
;main.c:128: playerlocation[1] = playerlocation[1] +2;
	ld	a, (#(_playerlocation + 1) + 0)
	add	a, #0x02
	ld	(#(_playerlocation + 1)),a
;main.c:129: move_sprite(0,playerlocation[0],playerlocation[1]);
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_playerlocation
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;main.c:130: if (currentSpriteIndex==0){
	ld	a, c
	or	a, a
	jr	NZ, 00129$
;main.c:131: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:132: set_sprite_tile(0,currentSpriteIndex);
	jr	00132$
00129$:
;main.c:134: }else if (currentSpriteIndex==2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00126$
;main.c:136: currentSpriteIndex = 3;
	ld	c, #0x03
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x03
;main.c:137: set_sprite_tile(0,currentSpriteIndex);
	jr	00132$
00126$:
;main.c:139: currentSpriteIndex = 2;
	ld	c, #0x02
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x02
;main.c:140: set_sprite_tile(0,currentSpriteIndex);
00132$:
;main.c:145: if((joypad() & J_A) || jumping == 1){
	call	_joypad
	bit	4, e
	jr	NZ, 00133$
;setupPair	HL
	ld	a, (#_jumping)
	dec	a
	jr	NZ, 00134$
00133$:
;main.c:146: jump(0,playerlocation);
	push	bc
	ld	de, #_playerlocation
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_jump
	add	sp, #3
	pop	bc
00134$:
;main.c:149: performantdelay(5);
	push	bc
	ld	a, #0x05
	push	af
	inc	sp
	call	_performantdelay
	inc	sp
	pop	bc
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:150: set_sprite_tile(0,0);
	jp	00137$
;main.c:154: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__yuckChar:
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x03	; 3
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc0	; 192
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xc9	; 201
	.db #0x7e	; 126
	.db #0xb1	; 177
	.db #0x7e	; 126
	.db #0xb1	; 177
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x93	; 147
	.db #0x7e	; 126
	.db #0x8d	; 141
	.db #0x7e	; 126
	.db #0x8d	; 141
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xc9	; 201
	.db #0x7e	; 126
	.db #0xb1	; 177
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x93	; 147
	.db #0x7e	; 126
	.db #0x8d	; 141
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x00	; 0
__xinit__gravity:
	.db #0xfe	; 254
__xinit__floorYposition:
	.db #0x64	; 100	'd'
	.area _CABS (ABS)
