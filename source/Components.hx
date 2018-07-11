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
            trace("Attacked for ", damage, " hit points");
        }
        else
        {
            trace("Attacked for no damage");
        }
    }
}