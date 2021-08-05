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
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _Smile
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_Smile::
	.ds 32
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
;main.c:5: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:8: set_sprite_data(0,2,Smile);
	ld	de, #_Smile
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:11: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:13: while(1){
00107$:
;main.c:14: switch(joypad()){
	call	_joypad
	ld	a, e
	dec	a
	jr	Z, 00102$
	ld	a,e
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x04
	jr	Z, 00103$
	sub	a, #0x08
	jr	Z, 00104$
	jr	00105$
;main.c:15: case J_LEFT:
00101$:
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0xf6
	ld	(bc), a
;main.c:17: break;
	jr	00105$
;main.c:18: case J_RIGHT:
00102$:
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0x0a
	ld	(bc), a
;main.c:20: break;
	jr	00105$
;main.c:21: case J_UP:
00103$:
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0xf6
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:23: break;
	jr	00105$
;main.c:24: case J_DOWN:
00104$:
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0x0a
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:27: }
00105$:
;main.c:31: delay(10);
	ld	de, #0x000a
	push	de
	call	_delay
	pop	hl
;main.c:38: }
	jr	00107$
	.area _CODE
	.area _INITIALIZER
__xinit__Smile:
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.area _CABS (ABS)
