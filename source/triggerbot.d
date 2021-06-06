module triggerbot;

import core.sys.windows.windows;
import core.thread;
import std.stdio;
import tier;
import game;


class Triggerbot : Tier 
{
    // Change this to false if you're going to be a dick and play outside of deathmatches.
    bool deathMatch = true;

    this(Game game)
    {
        super( "Triggerbot", VK_HOME, 10, game );
    }

    override void run()
    {
        for ( ;; )
        {
            super.listenForToggle();

            if ( this.status )
            {
                int crosshairId = this.game.getCrosshairId();
                if ( crosshairId != 0 && crosshairId <= 64 )
                {
                    DWORD badguy     = this.game.getIntersectingBadguy( crosshairId );
                    int badguyHealth = this.game.getBadguyHealth( badguy );
                    int badguyTeam   = this.game.getBadguyTeam( badguy );
                    int myTeam       = this.game.getMyTeam();

                    writeln( "My team: ", myTeam );
                    writeln( "Enemy Team: ", badguyTeam );
                    writeln( "Badguy Health: ", badguyHealth );

                    if ( !this.deathMatch )
                    {
                        if ( myTeam != badguyTeam && badguyHealth > 0 )
                        {
                            this.game.tapTheDog();
                        }
                    }
                    else
                    {
                        if ( badguyHealth > 0 )
                        {
                            this.game.tapTheDog();
                        }
                    }
                }
            }
            
            Thread.sleep( dur!( "msecs" ) ( this.delay ) );

        }
    }
}
