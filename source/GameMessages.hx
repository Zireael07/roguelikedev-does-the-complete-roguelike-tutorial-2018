package;

class GameMessage {
    public var _txt:String;

    public function new(text:String, color=flixel.util.FlxColor.WHITE):Void {
        _txt = text;
    }
}

class MessageLog {
    var _x:Int;
    var _w:Int;
    var _h:Int;
    public static var _messages:Array<GameMessage> = [];

    public function new(x:Int, width:Int, height:Int):Void {
        _x = x;
        _w = width;
        _h = height;
        _messages = [];
        //_messages = Array<GameMessage>;
    }

    public static function addMessage(msg:GameMessage):Void {
        _messages.push(msg);
    }
}