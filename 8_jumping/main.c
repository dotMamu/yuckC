#include <gb/gb.h>
#include <stdio.h>
#include "yuck.c"



INT8 playerlocation[2];
BYTE jumping;
UINT8 gravity = -2;
UINT8 currentspeedY;
UINT8 floorYposition = 100;
void performantdelay(UINT8 numloops){
    UINT8 i;
    for( i = 0; i < numloops;i++){
        wait_vbl_done();

    }

}

INT8 wouldhitsurface(UINT8 projectedYposition){
if(projectedYposition>= floorYposition){
    return floorYposition;
}
return -1;
}

void jump(UINT8 spriteid, UINT8 spritelocation[2]){
    INT8 possiblesurfaceY;

    if(jumping ==0 ){
        jumping = 1;
        currentspeedY = 10;
    }
    
    // work out current speed - effect of gravities accelleration down
    currentspeedY = currentspeedY + gravity;
    
    spritelocation[1] = spritelocation[1] - currentspeedY;

    possiblesurfaceY = wouldhitsurface(spritelocation[1]);
    
    if(possiblesurfaceY > -1){
        jumping = 0;
        set_sprite_tile(spriteid,2);
        move_sprite(spriteid,spritelocation[0],possiblesurfaceY);
    }else{
        set_sprite_tile(spriteid,1);
        move_sprite(spriteid,spritelocation[0],spritelocation[1]);
    }
    
   
    

}

void main(){

    UINT8 currentSpriteIndex = 0;

    set_sprite_data(0,10,yuckChar);
    set_sprite_tile(0,0);
    playerlocation[0] = 10;
    playerlocation[1] = 100;
    jumping = 0;

    move_sprite(0,playerlocation[0],playerlocation[1]);

    DISPLAY_ON;
    SHOW_SPRITES;

    while(1){

        if(joypad() & J_LEFT){
            playerlocation[0] = playerlocation[0] -2;
            move_sprite(0,playerlocation[0],playerlocation[1]);
            if (currentSpriteIndex==0){
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }else if (currentSpriteIndex==2)
            {
                currentSpriteIndex = 3;
                set_sprite_tile(0,currentSpriteIndex);
            }else{
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }
            
        }
        if(joypad() & J_RIGHT){
            playerlocation[0] = playerlocation[0] +2;
            move_sprite(0,playerlocation[0],playerlocation[1]);
            if (currentSpriteIndex==0){
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }else if (currentSpriteIndex==2)
            {
                currentSpriteIndex = 3;
                set_sprite_tile(0,currentSpriteIndex);
            }else{
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }
            
        }
        if(joypad() & J_UP){
            playerlocation[1] = playerlocation[1] -2;
            move_sprite(0,playerlocation[0],playerlocation[1]);
            if (currentSpriteIndex==0){
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }else if (currentSpriteIndex==2)
            {
                currentSpriteIndex = 3;
                set_sprite_tile(0,currentSpriteIndex);
            }else{
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }
        }
        if(joypad() & J_DOWN){
            playerlocation[1] = playerlocation[1] +2;
            move_sprite(0,playerlocation[0],playerlocation[1]);
            if (currentSpriteIndex==0){
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }else if (currentSpriteIndex==2)
            {
                currentSpriteIndex = 3;
                set_sprite_tile(0,currentSpriteIndex);
            }else{
                currentSpriteIndex = 2;
                set_sprite_tile(0,currentSpriteIndex);

            }

        }
        if((joypad() & J_A) || jumping == 1){
            jump(0,playerlocation);

        }
        performantdelay(5);
        set_sprite_tile(0,0);
    }


}