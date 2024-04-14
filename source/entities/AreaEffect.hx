package entities;

import flixel.FlxSprite;

class AreaEffect extends CenterableEntity {
	public var id:Int = -1;
	public var radius:Float = 1.0;
	public var potency:Float = 1.0;
	public var entities:List<BaseEntity> = new List<BaseEntity>();
	public var toAdd:List<BaseEntity> = new List<BaseEntity>();
	public var toRemove:List<BaseEntity> = new List<BaseEntity>();

	public function new(x:Float, y:Float, radius:Float, potency:Float=1.0) {
		super(x, y);
		id = EntityIdManager.instance.get();
		this.radius = radius;
		this.potency = potency;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if (toRemove.length > 0) {
			for (entity in toRemove) {
				entities.remove(entity);
			}
		}
		if (toAdd.length > 0) {
			for (entity in toAdd) {
				entities.add(entity);
			}
		}
	}

	public function onEnter(entity:BaseEntity) {
		toAdd.add(entity);
	}

	public function onExit(entity:BaseEntity) {
		toRemove.add(entity);
	}
}