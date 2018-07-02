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
        //var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
        //text.screenCenter();
        //add(text);

        //sprite mapping to map values
        var SpriteByInt = [
            0 => AssetPaths.floor_sand__png,
            1 => AssetPaths.wall_stone__png,
        ];

        //a simple map
        game_map = generateArenaMatrix(8,8);

        // display said map
        for (y in 0 ... game_map.length) {
            for (x in 0 ... game_map[0].length) {
                var sprite = new flixel.FlxSprite();
                sprite.loadGraphic(SpriteByInt[game_map[y][x]], false, 32, 32);
                var _cartCoords:Array<Int> = cartesianCoords(x,y);
                var coords:Array<Int> = isoCoordsFromCartesian(_cartCoords[0], _cartCoords[1]);
                sprite.x = coords[0];
                sprite.y = coords[1];

                add(sprite);
            }
        }



        //sprite
        player = new Entity(x_start, y_start);

        add(player);
	}

	override public function update(elapsed:Float):Void
	{
		updatePlayer();
        super.update(elapsed);
	}

    //movement
    function updatePlayer():Void
    {
        
        if (FlxG.keys.anyJustPressed([LEFT, H]))
        {
            player.move(-1,0, game_map);

        }
        else if (FlxG.keys.anyJustPressed([RIGHT, L]))
        {
            player.move(1,0, game_map);

        }
        else if (FlxG.keys.anyJustPressed([UP, K]))
        {
            player.move(0,-1, game_map);
        }

        else if (FlxG.keys.anyJustPressed([DOWN, J]))
        {
            player.move(0,1, game_map);

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
        var isoX = x - y + offset;
        var _isoY:Float = (x + y) / 2; //always returns a float 

        

        var isoY:Int = Math.round(_isoY);
        return [isoX, isoY];
    }

    /**
     * Creates a matrix (2-dimensional array of Ints) of an empty map consisting of zeros only.
     * 
     * @param   Columns     Number of columns for the matrix
     * @param   Rows        Number of rows for the matrix
     * @return  Spits out a matrix that is columns * rows big, initiated with zeros
     */
    static function generateInitialMatrix(Columns:Int, Rows:Int):Array<Array<Int>>
    {
        var matrix:Array<Array<Int>> = new Array<Array<Int>>();
        
        for (y in 0...Rows)
        {
            matrix.push(new Array<Int>());
            
            for (x in 0...Columns) 
            {
                matrix[y].push(0);
            }
        }
        
        return matrix;
    }


    public static function generateArenaMatrix(Columns:Int, Rows:Int):Array<Array<Int>>
    {
        // Initialize random array
        var matrix:Array<Array<Int>> = generateInitialMatrix(Columns, Rows);
        
        for (y in 0...Rows)
        {
            for (x in 0...Columns) 
            {
                if ((y == 0 || y == Rows-1) || (x == 0 || x == Columns-1))
                {
                    matrix[y][x] = 1;
                }
                else
                {
                    matrix[y][x] = 0;
                }

            }
        }

        return matrix;
    }

}

