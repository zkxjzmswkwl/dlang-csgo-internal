module bunnyhop;

import core.sys.windows.windows;
import core.thread;
import game;
import tier;

class Bunnyhop :  Tier
{
    this( Game game )
    {
        super( "Bunnyhop", VK_NEXT, 10, game );
    }

    override void run()
    {
        for ( ;; )
        {
            super.listenForToggle();

            if ( this.status )
            {
                if ( GetAsyncKeyState( VK_SPACE ) && this.game.getJumpFlags() & 1 )
                {
                    this.game.jump();
                }
            }
            Thread.sleep( dur!( "msecs" )( this.delay ) );
        }
    }
}