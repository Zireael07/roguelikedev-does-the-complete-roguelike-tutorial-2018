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

    //override public function update(elapsed:Float):Void {
    public function update():Void{
        //healthBar.x = FlxG.camera.scroll.x + 10;
        //healthBar.y = FlxG.camera.scroll.y + 20;

        this._msgLayer.clear();

        //super.update(elapsed);
        
    }

}