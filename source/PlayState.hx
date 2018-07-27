package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxSave;

class PlayState extends FlxState
{
    //for testing
    var x_start:Int = 2;
    var y_start:Int = 2;
    var player:Entity;
    var ui:UI;
    var messages:GameMessages.MessageLog;
    var game_map:Array<Array<Int>>;
    var tilemap:IsoTilemap;

    var fov:FOV.Vision;
    //fractional so that cardinal directions do not "stick out"
    var fov_range:Float = 2.5;

    var num_monsters:Int = 2;
    var num_items:Int = 2;

    public var entities:Array<Entity> = [];
    var entities_group:flixel.group.FlxGroup;

    var ui_overlays:Array<flixel.group.FlxGroup> = [];
    var open_inv = false;

    // Here's the FlxSave variable that we're going to be saving to.
    var _gameSave:FlxSave;

    override public function create():Void
	{
		super.create();

        // you have to instantiate a new one before you can use it
        _gameSave = new FlxSave();
        // And then you have to bind it to the save data, you can use different bind strings in different parts of your game
        // you MUST bind the save before it can be used.
        _gameSave.bind("SaveDemo");

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

        entities_group = new flixel.group.FlxGroup();

        // monsters
        for (i in 0 ... num_monsters) {
            var mon_actor = new Components.Actor(5,11,10);
            var mon_ai = new AI();
            //we know that 0 and game_map.length-1 are guaranteed to be walls
            var monster = new Entity("kobold", random_int(1, game_map[0].length-2), random_int(1, game_map.length-2), "assets/images/kobold.png", mon_actor, mon_ai);
            entities.push(monster);
            entities_group.add(monster);
        }

        // items
        for (i in 0 ... num_items){
            var item_c = new Components.Item();
            var item = new Entity("potion", random_int(1, game_map[0].length-2), random_int(1, game_map.length-2), "assets/images/potion.png", item_c);
            entities.push(item);
            entities_group.add(item);
        }


        //player
        var inventory = new Components.Inventory(26);
        var player_actor = new Components.Actor(30, 12, 10);
        player = new Entity("player", x_start, y_start, "assets/images/human_m.png", player_actor, inventory);

        entities_group.add(player);
        entities.push(player);

        add(entities_group);

        ui = new UI();
        add(ui._Layer);
        add(ui._msgLayer);

        //we made it static so we don't need an instance
        //messages = new GameMessages.MessageLog(20, 100, 5);

        drawAll(fov);

        //camera
        FlxG.camera.follow(player, LOCKON, 1);
	}

	override public function update(elapsed:Float):Void
	{
		ui.update();
        updatePlayer();

        var y = 300;
        if (GameMessages.MessageLog._messages.length > 0)
        {
            for (msg in GameMessages.MessageLog._messages)
            {
                //trace("should show", msg._txt);
                var txt = new flixel.text.FlxText(10,y, 0, msg._txt, 16);
                ui._msgLayer.add(txt);        
                // HUD elements shouldn't move with the camera
                txt.scrollFactor.set(0, 0);
                y += 18;
            }    
        }
        
            

        super.update(elapsed);
	}

    //movement
    function updatePlayer():Void
    {
        
        if (FlxG.keys.anyJustPressed([LEFT, H]))
        {
            if (player.getActorAtLoc(player._x-1, player._y, entities) != null)
            {
                player._actor.attack(player.getEntityAtLoc(player._x-1, player._y, entities));
                //trace("You push at the enemy!");
            }
            else
            {
                player.move(-1,0, game_map);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
            

        }
        else if (FlxG.keys.anyJustPressed([RIGHT, L]))
        {
            if (player.getActorAtLoc(player._x+1, player._y, entities) != null)
            {
                //trace("You push at the enemy!");
                player._actor.attack(player.getEntityAtLoc(player._x+1, player._y, entities));
            }
            else{
                player.move(1,0, game_map);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);    
            }
            

        }
        // it picks up the K in Shift+Ctrl+K to open browser console
        else if (FlxG.keys.anyJustPressed([UP]))
        {
            if (player.getActorAtLoc(player._x, player._y-1, entities) != null)
            {
                //trace("You push at the enemy!");
                player._actor.attack(player.getEntityAtLoc(player._x, player._y-1, entities));
            }
            else{
                player.move(0,-1, game_map);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
        }

        else if (FlxG.keys.anyJustPressed([DOWN, J]))
        {
            if (player.getActorAtLoc(player._x, player._y+1, entities) != null)
            {
                //trace("You push at the enemy!");
                player._actor.attack(player.getEntityAtLoc(player._x, player._y+1, entities));
            }
            else{
                player.move(0,1, game_map);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
        }
        else if (FlxG.keys.anyJustPressed([G]))
        {
            var it = player.getItemAtLoc(player._x, player._y, entities);
            if (it != null)
            {
                //remove from screen
                remove(it);
                it.kill();
                player._inventory.addItem(it);
                //remove from entities
                entities.remove(it);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);

            }
            else{
                var str = new String("No item here to pick up");
                var msg = new GameMessages.GameMessage(str);
                GameMessages.MessageLog.addMessage(msg);

                //AI moves
                for (e in entities)
                {
                    if (e._ai != null){
                        e._ai.take_turn(player, game_map, entities);
                    }
                }

                fov.calculateShadowcast(player._x, player._y, fov_range);
                drawAll(fov);
            }
        }
        else if (FlxG.keys.anyJustPressed([I]) && open_inv == false)
        {
            var layer = ui.inventoryMenu(player._inventory.items);
            trace("Should show inventory");
            add(layer);
            ui_overlays.push(layer);
            open_inv = true;
        }
        else if (FlxG.keys.anyJustPressed([Q]) && open_inv == true){
            open_inv = false;
            var inv_layer = ui_overlays[0];
            inv_layer.kill();
            ui_overlays.remove(inv_layer);
            trace("Should close inventory");

        }
        //save-load
        else if (FlxG.keys.anyJustPressed([S]))
        {
            save();
        }
        else if (FlxG.keys.anyJustPressed([O]))
        {
            load();
            //redraw
            fov.calculateShadowcast(player._x, player._y, fov_range);
            drawAll(fov);
        }
    }
    
    public function save():Void {
        trace("Saving game...");
        //_gameSave.data.player_pos = new Array();
        //_gameSave.data.player_pos.push(player._x);
        //_gameSave.data.player_pos.push(player._y);
        _gameSave.data.player_items = new Array();
        _gameSave.data.player_items = player._inventory.items.copy();
        //trace("Items: ", _gameSave.data.player_items);
        _gameSave.data.entities_pos = new Array();
        // entities_group.members is always updated, so we can't retrieve data from the moment of saving
        //_gameSave.data.entities = entities_group.members.copy();
        for (e_id in 0...entities.length){
            trace("Saving entity..", entities[e_id]);
            var pos = new Array<Int>();
            var e = entities[e_id];
            pos.push(e._x);
            pos.push(e._y);
            trace("Saved...", pos);
            _gameSave.data.entities_pos.push(pos);
        }
        //trace("Player id", entities_group.members.indexOf(player));
        //trace("Player", player);
    }

    public function load():Void {
        trace("Loading game...");
        if (_gameSave.data.entities_pos != null)
        {
            trace("Loaded game");

            for (id in 0..._gameSave.data.entities_pos.length){
                trace("Loaded entity id", id, "entity:", _gameSave.data.entities_pos[id]);
                if (id < entities.length){
                //for (e_id in 0...entities.length){
                    var e = entities[id];
                    e._x = _gameSave.data.entities_pos[id][0];
                    e._y = _gameSave.data.entities_pos[id][1];
                    trace("Setting entity", id, " to ", e._x, e._y);
                }
            }

            //very basic
            //player._x = _gameSave.data.player_pos[0];
            //player._y = _gameSave.data.player_pos[1];
            //trace("Position: ", _gameSave.data.player_pos[0], _gameSave.data.player_pos[1]);
            //trace("Setting player to saved position", player._x, player._y);
            trace("Items in save", _gameSave.data.player_items);
            //clear array
            player._inventory.items = [];
            for (id in 0 ..._gameSave.data.player_items.length){
                player._inventory.items.push(_gameSave.data.player_items[id]);
            }
            // doesn't work because loaded data is Dynamic
            //player._inventory.items = _gameSave.data.player_items.copy();
        }
    }


    public function drawAll(fov:FOV.Vision):Void {
        tilemap.drawMap(game_map, fov);
        
        for (e in entities) {
            e._draw(fov);
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

    //randomness
    /** Return a random integer between 'from' and 'to', inclusive. */
    public static inline function random_int(from:Int, to:Int):Int
    {
        return from + Math.floor(((to - from + 1) * Math.random()));
    }
}

