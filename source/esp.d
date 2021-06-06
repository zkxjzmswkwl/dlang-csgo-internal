module esp;

import core.sys.windows.windows;
import core.thread;
import std.stdio;
import tier;
import game;

//    ________      __          __   _____                       _ ____                    
//   / ____/ /___  / /_  ____ _/ /  / ___/__  ________   _____  (_) / /___ _____  ________ 
//  / / __/ / __ \/ __ \/ __ `/ /   \__ \/ / / / ___/ | / / _ \/ / / / __ `/ __ \/ ___/ _ \
// / /_/ / / /_/ / /_/ / /_/ / /   ___/ / /_/ / /   | |/ /  __/ / / / /_/ / / / / /__/  __/
// \____/_/\____/_.___/\__,_/_/   /____/\__,_/_/    |___/\___/_/_/_/\__,_/_/ /_/\___/\___/ 
// China themed ESP. Enemies flash in the color China's flag, while teamates are a static color.
                                                                                        

class Esp : Tier
{
    this(Game game)
    {
        super( "Global Surveillance", VK_PRIOR, 3, game );
    }

    void setGlow(bool redOrYellow, DWORD badguy, DWORD glowObj, DWORD glowIndice)
    {
        if ( redOrYellow )
        {
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x4) )  = 225.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x8) )  = 223.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x8) )  = 0.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x10) ) = 1.3f;
        }
        else
        {
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x4) )  = 223.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x8) )  = 36.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x8) )  = 7.0f;
            *cast(float*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x10) ) = 1.3f;
        }
    }

    override void run()
    {
        bool redOrYellow = false;

        for ( ;; )
        {
            super.listenForToggle();
            if ( this.status )
            {

                for ( int i = 1; i < 32; i++ )
                {
                    DWORD badguy = *cast(DWORD*)( ( game.mClient + game.dwEntityList ) + i * cast(DWORD)0x10 );

                    if ( badguy <= 0 ) continue;

                    int glowIndice = game.getGlowIndice( badguy );
                    int badguyTeam = game.getBadguyTeam( badguy );
                    int badassTeam = game.getMyTeam();
                    DWORD glowObj  = game.getGlowObj();

                    if ( badguyTeam == badassTeam )
                    {
                        setGlow( false, badguy, glowObj, glowIndice );
                    }
                    else
                    {
                        setGlow( redOrYellow, badguy, glowObj, glowIndice  );
                    }

                    *cast(bool*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x24 ) ) = true;
                    *cast(bool*)( ( glowObj + glowIndice * cast(DWORD)0x38 + cast(DWORD)0x25 ) ) = false;
                }

                redOrYellow = !redOrYellow;
            }
            Thread.sleep( dur!( "msecs" )( this.delay ) );
        }
    }
}
