package;

import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	/* Some static constants */
    static inline var TILE_WIDTH:Int = 32;
    static inline var TILE_HEIGHT:Int = 32;

    //for testing
    var x_start:Int = 2;
    var y_start:Int = 2;
    var player:Entity;
    var game_map:Array<Array<Int>>;

    override public function create():Void
	{
		super.create();
        //hello world
        var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
        text.screenCenter();
        add(text);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

}

