package entities;

import flixel.FlxSprite;

class EntityIdManager {
	public static var instance = new EntityIdManager();

	public var count:Int = 0;

	public function new() {
	}

	public function get():Int {
		var i = count;
		count++;
		return i;
	}
}