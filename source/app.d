import std.stdio;
import core.sys.windows.windows;
import core.thread;
import core.runtime;
import std.concurrency;
import game;
import triggerbot;
import bunnyhop;
import esp;


void initialize()
{
	Game game = new Game();
	writeln( "Welcome back, Chairman Mao." );

	// If you try to add a fourth thread in the same fashion, you will need
	// to rework how you're spawning the threads.
	new Thread(() {
		new Triggerbot( game ).run();
	}).start();

	new Thread(() {
		new Bunnyhop( game ).run();
	}).start();

	new Thread(() {
		new Esp( game ).run();
	}).start();
}

extern ( Windows )
BOOL DllMain(HINSTANCE module_, uint reason, void*)
{
	if ( reason == DLL_PROCESS_ATTACH )
	{
		Runtime.initialize;
		AllocConsole();
		freopen( "CON", "w", stdout.getFP );
		initialize();
	}
	else if ( reason == DLL_PROCESS_DETACH )
	{
		MessageBoxA( null, "Ejected", ":O", MB_OK );
		Runtime.terminate;
	}
	return true;
}
