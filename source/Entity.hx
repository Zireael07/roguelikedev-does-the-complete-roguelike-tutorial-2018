package;

import flixel.FlxSprite;
import flixel.FlxG;

class Entity extends FlxSprite {

    var _x:Int;
    var _y:Int;

    /**
     * Constructor
     * @param name
     * @param   x
     * @param   y
     */
    public function new(x:Int, y:Int):Void {
        super(0,0, "assets/images/human_m.png");
        _x = x;
        _y = y;
        _draw();

    }

    public function move(dx:Int, dy:Int, map:Array<Array<Int>>):Void
    {
        if (_y + dy < 0 || _y + dy > map.length)
        {
            trace("Tried to move out of map bounds");
            return;
        }

        if (_x + dx < 0 || _x + dx > map[0].length)
        {
            trace("Tried to move out of map bounds");
            return;
        }

        if (map[_y + dy][_x + dx] == 1){
            trace("You can't move into a wall");
            return;
        }

        _x += dx;
        _y += dy;
        _draw();
    }

    // drawing functions
    public function _draw():Void
    {
        var _cartCoords:Array<Int> = cartesianCoords(_x, _y);
        var coords:Array<Int> = isoCoordsFromCartesian(_cartCoords[0], _cartCoords[1]);

        x = coords[0]+8; // a quarter of a tile
        y = coords[1]+16;
    }


    //coordinates
    public function cartesianCoords(x:Int, y:Int):Array<Int>
    {
        var _x:Int= x*32; //hardcoded for now
        var _y:Int = y*32;

        return [_x, _y];
    }

    //This one takes cartesians
    public function isoCoordsFromCartesian(x:Int, y:Int):Array<Int>
    {
        var offset = Math.round(FlxG.stage.stageWidth/2);
        // taken from "An updated primer for creating isometric worlds" tutorial
        var isoX = x - y + offset;
        var _isoY:Float = (x + y) / 2; //always returns a float 

        var isoY:Int = Math.round(_isoY);
        return [isoX, isoY];
    }


}