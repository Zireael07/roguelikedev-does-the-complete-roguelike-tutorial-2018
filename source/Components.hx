package;

class Actor {
    public var _hp:Int;
    var max_hp:Int;
    var defense:Int;
    var power:Int;
    public var owner:Entity;

    public function new(hp:Int, pow:Int, def:Int):Void {
        _hp = hp;
        max_hp = hp;
        defense = def;
        power = pow;
    }

    public function takeDamage(amount:Int):Void {
        _hp -= amount;
    }

    public function attack(target:Entity):Void {
        var damage = power - target._actor.defense;
        if (damage > 0)
        {
            target._actor.takeDamage(damage);
            var str = new String("Attacked for " + damage + " hp! ");
            var msg = new GameMessages.GameMessage(str);
            GameMessages.MessageLog.addMessage(msg);
            //trace("Attacked for ", damage, " hit points");
        }
        else
        {
            trace("Attacked for no damage");
        }
    }
}

class Item {
    public var owner:Entity;

    public function new():Void {
        
    }
}

class Inventory {
    var capacity:Int;
    var items:Array<Entity> = [];

    public var owner:Entity;

    public function new(cap:Int):Void {
        capacity = cap;
    }

    public function addItem(item:Entity):Void {
        if (items.length >= capacity){
            var str = new String("Cannot carry any more!");
            var msg = new GameMessages.GameMessage(str);
            GameMessages.MessageLog.addMessage(msg);
        }
        else{
            var str = new String("You picked up an item!");
            var msg = new GameMessages.GameMessage(str);
            GameMessages.MessageLog.addMessage(msg);

            items.push(item);
        }
    }
}