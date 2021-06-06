module tier;

import core.sys.windows.windows;
import core.thread;
import std.stdio;
import game;

class Tier : Thread
{

    Game   game;
    string name;
    int    toggle;
    int    delay;
    bool   status;
    

public:
    this (string name, int toggle, int delay, Game game)
    {
        this.game   = game;
        this.name   = name;
        this.toggle = toggle;
        this.delay  = delay;
        this.status = false;
        writeln( "Tier -| " ~ name ~ " |-" );

        super( &run );
    }

    abstract void run();

    void listenForToggle()
    {
        if ( GetAsyncKeyState( this.toggle ) & 1 )
        {
            this.status = !this.status;
        }
    }

}
