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
	.globl _joypad
	.globl _delay
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
;main.c:4: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:7: NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:8: NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:9: NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:12: while(1){
00104$:
;main.c:13: UBYTE joypad_state = joypad();
	call	_joypad
	ld	a, e
;main.c:14: if(joypad_state){
	or	a, a
	jr	Z, 00104$
;main.c:18: NR41_REG = 0x1F;
	ld	a, #0x1f
	ldh	(_NR41_REG + 0), a
;main.c:25: NR42_REG = 0xF1;
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;main.c:34: NR43_REG = 0x30;
	ld	a, #0x30
	ldh	(_NR43_REG + 0), a
;main.c:41: NR44_REG = 0xC0;  
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;main.c:43: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;main.c:47: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
