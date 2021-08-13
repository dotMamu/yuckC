#include <gb/gb.h>
#include <stdio.h>
#include "MazeSpritesl.c"
#include "MazeMap.c"
#include "snail.c"

UINT8 playerlocation[2];

void performantdelay(UINT8 numloops){
    UINT8 i;
    for ( i = 0; i < numloops; i++)
    {
        wait_vbl_done();
    }
}

UBYTE canplayermove(UINT8 newplayerx, UINT8 newplayery){
    UINT16 indexTLx, indexTLy, tileindexTL;
    indexTLx = (newplayerx - 8) / 8;
    indexTLy = (newplayery -16) / 8;

}

void main(){

    set_bkg_data(0,4,MazeSprites);
    set_bkg_tiles(0,0,20,18, MazeMap);

    set_sprite_data(0,1,snail);
    set_sprite_tile(0,0);

    playerlocation[0] = 16;
    playerlocation[1] = 24;

    move_sprite(0,playerlocation[0], playerlocation[1]);

    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;

    while (1)
    {
        if(joyad() & J_LEFT){
            playerlocation[0] -=8;
            move_sprite(0,playerlocation[0],playerlocation[1]);

        }
        else if(joyad() & J_RIGHT){
            playerlocation[0] +=8;
            move_sprite(0,playerlocation[0],playerlocation[1]);

        }
        else if(joyad() & J_UP){
            playerlocation[1] -=8;
            move_sprite(0,playerlocation[0],playerlocation[1]);

        }
        else if(joyad() & J_DOWN){
            playerlocation[1] +=8;
            move_sprite(0,playerlocation[0],playerlocation[1]);

        }
    }
    

}