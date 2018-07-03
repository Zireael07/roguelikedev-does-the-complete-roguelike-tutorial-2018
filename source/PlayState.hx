package;

import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
    //for testing
    var x_start:Int = 2;
    var y_start:Int = 2;
    var player:Entity;
    var game_map:Array<Array<Int>>;
    var tilemap:IsoTilemap;

    var fov:FOV.Vision;
    //fractional so that cardinal directions do not "stick out"
    var fov_range:Float = 2.5;

    override public function create():Void
	{
		super.create();

        //hello world
        //var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
        //text.screenCenter();
        //add(text);

        //a simple map
        game_map = generateArenaMatrix(8,8);

        tilemap = new IsoTilemap(game_map);
        add(tilemap._Layer);

        //fov
        fov = new FOV.Vision(game_map);
        fov.calculateShadowcast(x_start, y_start, fov_range);


        tilemap.drawMap(game_map, fov);



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
            fov.calculateShadowcast(player._x, player._y, fov_range);
            tilemap.drawMap(game_map, fov);

        }
        else if (FlxG.keys.anyJustPressed([RIGHT, L]))
        {
            player.move(1,0, game_map);
            fov.calculateShadowcast(player._x, player._y, fov_range);
            tilemap.drawMap(game_map, fov);

        }
        else if (FlxG.keys.anyJustPressed([UP, K]))
        {
            player.move(0,-1, game_map);
            fov.calculateShadowcast(player._x, player._y, fov_range);
            tilemap.drawMap(game_map, fov);
        }

        else if (FlxG.keys.anyJustPressed([DOWN, J]))
        {
            player.move(0,1, game_map);
            fov.calculateShadowcast(player._x, player._y, fov_range);
            tilemap.drawMap(game_map, fov);

        }
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

