package;

import flixel.FlxG;

class IsoTilemap {
    /* Some static constants */
    static inline var TILE_WIDTH:Int = 32;
    static inline var TILE_HEIGHT:Int = 32;


    public var _Layer:flixel.group.FlxGroup;
    public var _explored:Array<Array<Bool>>;

    //sprite mapping to map values
    var SpriteByInt = [
        0 => AssetPaths.floor_sand__png,
        1 => AssetPaths.wall_stone__png,
    ];

    public function new(game_map:Array<Array<Int>>):Void 
    {
        this._Layer = new flixel.group.FlxGroup();
        this._explored = [for (i in 0...game_map.length) [for (j in 0...game_map[0].length) false]];
    }

    public function drawMap(game_map:Array<Array<Int>>, fov:FOV.Vision):Void 
    {
        //clear tiles
        _Layer.clear();
        
        for (y in 0 ... game_map.length) {
            for (x in 0 ... game_map[0].length) {

                if (fov.lightMap[x][y] == 0)
                {
                    // draw explored, too
                    if (this._explored[y][x])
                    {
                        var sprite = new flixel.FlxSprite();
                        sprite.loadGraphic(SpriteByInt[game_map[y][x]], false, 32, 32);

                        sprite.color = flixel.util.FlxColor.GRAY;
                        //tint
                        //sprite.color = flixel.util.FlxColor.fromRGB(127,127,127); //, 200);

                        var _cartCoords:Array<Int> = cartesianCoords(x,y);
                        var coords:Array<Int> = isoCoordsFromCartesian(_cartCoords[0], _cartCoords[1]);
                        sprite.x = coords[0];
                        sprite.y = coords[1];

                        //add(sprite);
                        //add to flxgroup
                        _Layer.add(sprite);
                    }

                }
            
                // draw if in FOV
                else
                {
                    var sprite = new flixel.FlxSprite();
                    sprite.loadGraphic(SpriteByInt[game_map[y][x]], false, 32, 32);

                    var _cartCoords:Array<Int> = cartesianCoords(x,y);
                    var coords:Array<Int> = isoCoordsFromCartesian(_cartCoords[0], _cartCoords[1]);
                    sprite.x = coords[0];
                    sprite.y = coords[1];

                    //add(sprite);
                    //add to flxgroup
                    _Layer.add(sprite);

                     // mark as explored
                    this._explored[y][x] = true;
                }

            }
        }
    }

    //coordinates
    public function cartesianCoords(x:Int, y:Int):Array<Int>
    {
        var _x:Int= x*TILE_WIDTH;
        var _y:Int = y*TILE_HEIGHT;

        return [_x, _y];
    }

    //This one takes cartesians
    public function isoCoordsFromCartesian(x:Int, y:Int):Array<Int>
    {
        var offset = Math.round(FlxG.stage.stageWidth/2);

        // taken from "An updated primer for creating isometric worlds" tutorial
        var isoX = x - y; //+ offset;
        var _isoY:Float = (x + y) / 2; //always returns a float 

        

        var isoY:Int = Math.round(_isoY);
        return [isoX, isoY];
    }


}