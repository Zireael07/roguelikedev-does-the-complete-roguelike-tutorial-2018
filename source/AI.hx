package;

class AI {

    public var owner:Entity;
    
    public function new():Void {
        
    }

    public function take_turn(target:Entity, map:Array<Array<Int>>, entities:Array<Entity>):Void {
        //trace("Wonder when it will get to move");
        if (this.owner.visible){
            if (this.owner.distanceTo([target._x, target._y]) >= 2)
            {
                this.owner.move_towards(target._x, target._y, map, entities);
            }
            else if (target._actor._hp >= 0){
                this.owner._actor.attack(target);
                //trace("Monster insults you!");
            }
        }
    }
}