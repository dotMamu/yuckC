#include <gb/gb.h>

struct GameCharacter
{
    /* data */
    UBYTE spritids[4]; // todos los personajes usan 4 sprites
    UINT8 x;
    UINT8 y;
    UINT8 width;
    UINT8 height;

};
