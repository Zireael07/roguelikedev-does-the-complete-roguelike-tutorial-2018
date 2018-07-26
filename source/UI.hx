package;

import flixel.FlxG;

import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

//class UI extends flixel.group.FlxGroup.FlxTypedGroup<FlxSprite> {
class UI {
    private var setup: Bool = false;
    public var _Layer:FlxTypedGroup<FlxSprite>; //:flixel.group.FlxGroup;
    public var _msgLayer:flixel.group.FlxGroup;


    var healthBar:FlxBar;

    public function new():Void {
        //super();
        this._Layer = new FlxTypedGroup<FlxSprite>();
        this._msgLayer = new flixel.group.FlxGroup();

        setupUI();
    }

    public function setupUI():Void {
        if (setup){
            return;
        }

        healthBar = new FlxBar(10, 20, FlxBarFillDirection.LEFT_TO_RIGHT, 100, 10, null, "" , 0, 100, true);

        //add(healthBar);
        this._Layer.add(healthBar);

        // HUD elements shouldn't move with the camera
        this._Layer.forEach(function(thing:FlxSprite)
        {
            thing.scrollFactor.set(0, 0);
        });

        setup = true;
    }

    public function menu(layer:flixel.group.FlxGroup, x:Int, y:Int, header:String, items:Array<String>):Void {
        trace("Menu items", items);


        if (items.length > 26) { trace("Too many menu entries"); return; }


        var txt = new flixel.text.FlxText(x,y, 0, header, 18);
        layer.add(txt);
        txt.scrollFactor.set(0, 0);

        y = y + 20;
        for (i in items){
            var txt = new flixel.text.FlxText(x,y, 0, i, 16);
            layer.add(txt);
            txt.scrollFactor.set(0, 0);
            y = y + 18;
        }

    }

    public function inventoryMenu(items:Array<Entity>):flixel.group.FlxGroup {
        var names = new Array<String>();

        trace("Items passed: ", items);

        for (i in items){
            trace("Pushing names to list: ", i._name);
            names.push(i._name);
        }


        var grp = new flixel.group.FlxGroup();
        menu(grp, 50, 40, new String("INVENTORY"), names);
        
        return grp;
    }

    //override public function update(elapsed:Float):Void {
    public function update():Void{
        //healthBar.x = FlxG.camera.scroll.x + 10;
        //healthBar.y = FlxG.camera.scroll.y + 20;

        this._msgLayer.clear();

        //super.update(elapsed);
        
    }

}