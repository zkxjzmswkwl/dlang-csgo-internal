module game;

import std.stdio;
import core.sys.windows.windows;
import core.thread;

class Game
{
    // I understand that the naming conventions of these variables is meant to describe
    // the type of data that is stored in that memory location.
    // I don't care, in this codebase, they are DWORDS. So they are labeled as such.
    DWORD mClient;
    DWORD mEngine;
    DWORD dwLocalPlayer;
    DWORD dwForceAttack;
    DWORD dwForceJump;
    DWORD dwCrosshair;
    DWORD dwTeamNum;
    DWORD dwFlags;
    DWORD dwEntityList;
    DWORD dwHealth;
    DWORD dwGlowObj;
    DWORD dwGlowIndex;
    DWORD dwClientState;
    DWORD dwStateAngle;
    DWORD dwClientId;
    DWORD dwVec;
    DWORD dwVecView;
    DWORD dwFOV;

    public this()
    {
        mClient       = cast(DWORD)GetModuleHandleA( "client.dll" );
        mEngine       = cast(DWORD)GetModuleHandleA( "engine.dll" );
        dwLocalPlayer = cast(DWORD)0xD892CC;
        dwEntityList  = cast(DWORD)0x04DA215C;
        dwForceAttack = cast(DWORD)0x31D2690;
        dwForceJump   = cast(DWORD)0x0524BF4C;
        dwTeamNum     = cast(DWORD)0xF4;
        dwHealth      = cast(DWORD)0x100;
        dwGlowObj     = cast(DWORD)0x052EA5F8;
        dwGlowIndex   = cast(DWORD)0xA438;
        dwCrosshair   = cast(DWORD)0xB3E8;
        dwClientState = cast(DWORD)0x00588FEC;
        dwStateAngle  = cast(DWORD)0x4D90;
        dwClientId    = cast(DWORD)0x2FC8;
        dwVec         = cast(DWORD)0x138;
        dwVecView     = cast(DWORD)0x108;
        dwFOV         = cast(DWORD)0x31E8;
    }

    DWORD getClientState()
    {
        return *cast(DWORD*)( mEngine + dwClientState );
    }

    DWORD getLocalPlayer()
    {
        return *cast(DWORD*)( mClient + cast(DWORD)0xD892CC );
    }

    void tapTheDog()
    {
        *cast(DWORD*)( mClient + dwForceAttack ) = 6;
    }

    DWORD getEntityList()
    {
        return *cast(DWORD*)( mClient + dwEntityList );
    }

    DWORD getGlowObj()
    {
        return *cast(DWORD*)( mClient + dwGlowObj );
    }

    int getClientId(DWORD badguy)
    {
        return *cast(int*)( badguy + dwClientId );
    }

    int getGlowIndice(DWORD badguy)
    {
        return *cast(int*)( badguy + dwGlowIndex );
    }

    int getMyTeam()
    {
        return *cast(int*)( getLocalPlayer() + dwTeamNum );
    }

    int getBadguyHealth( DWORD badguy )
    {
        return *cast(int*)( badguy + dwHealth );
    }

    int getBadguyTeam( DWORD badguy )
    {
        return *cast(int*)( badguy + dwTeamNum );
    }

    int getCrosshairId()
    {
        return *cast(int*)( getLocalPlayer() + dwCrosshair );
    }

    DWORD getIntersectingBadguy(int cId)
    {
        return *cast(DWORD*)( mClient + dwEntityList + ( cId - 1 ) * cast(DWORD)0x10 );
    }

    DWORD getJumpFlags()
    {
        return *cast(DWORD*)( getLocalPlayer() + cast(DWORD)0x104 );
    }

    void jump()
    {
        *cast(DWORD*)( mClient + dwForceJump ) = 6;
    }
}