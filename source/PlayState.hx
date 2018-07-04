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

    var num_monsters:Int = 2;

    var entities:Array<Entity> = [];

    override public function create():Void
	{
		super.create();

        //hello world
        //var text = new flixel.text.FlxText(0, 0, 0, "Hello World", 64);
        //text.screenCenter();
        //add(text);

        //a simple map
        game_map = generateArenaMatrix(20,20);

        tilemap = new IsoTilemap(game_map);
        add(tilemap._Layer);

        //fov
        fov = new FOV.Vision(game_map);
        fov.calculateShadowcast(x_start, y_start, fov_range);

        //tilemap.drawMap(game_map, fov);

        // monsters
        for (i in 0 ... num_monsters) {
            //we know that 0 and game_map.length-1 are guaranteed to be walls
            var monster = new Entity(random_int(1, game_map[0].length-2), random_int(1, game_map.length-2), "assets/images/kobold.png");
            entities.push(monster);
            add(monster);
        }

        //sprite
        player = new Entity(x_start, y_start, "assets/images/human_m.png");

        add(player);
        entities.push(player);

        drawAll(fov);

        //camera
        FlxG.camera.follow(player, LOCKON, 1);
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
            if (getEntityAtLoc(player._x-1, player._y) != null)
            {
                trace("You push at the enemy!");
            }
            else
            {
                player.move(-1,0, game_map);
                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
            

        }
        else if (FlxG.keys.anyJustPressed([RIGHT, L]))
        {
            if (getEntityAtLoc(player._x+1, player._y) != null)
            {
                trace("You push at the enemy!");
            }
            else{
                player.move(1,0, game_map);
                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);    
            }
            

        }
        else if (FlxG.keys.anyJustPressed([UP, K]))
        {
            if (getEntityAtLoc(player._x, player._y-1) != null)
            {
                trace("You push at the enemy!");
            }
            else{
                player.move(0,-1, game_map);
                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
        }

        else if (FlxG.keys.anyJustPressed([DOWN, J]))
        {
            if (getEntityAtLoc(player._x, player._y+1) != null)
            {
                trace("You push at the enemy!");
            }
            else{
                player.move(0,1, game_map);
                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
        }
    }
    
    public function drawAll(fov:FOV.Vision):Void {
        tilemap.drawMap(game_map, fov);
        
        for (e in entities) {
            e._draw(fov);
        }
    }


    public function getEntityAtLoc(x:Int, y:Int):Entity {
        var ret:Entity = null;

        for (e in entities)
        {
            if (e._x == x && e._y == y)
            {
                ret = e;
                break;
            }
            else
            {
                ret = null;
            }
        }

        return ret;
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

    //randomness
    /** Return a random integer between 'from' and 'to', inclusive. */
    public static inline function random_int(from:Int, to:Int):Int
    {
        return from + Math.floor(((to - from + 1) * Math.random()));
    }
}

