package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class BaseStatusEffect {
	public var type:StatusEffect = StatusEffect.None;

	public var self:BaseEntity;
	public var lifespan:Float = 1.0;
	public var liveForever:Bool = false;
	public var priority:Int = 10;

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		this.self = self;
		this.lifespan = lifespan;
		if (lifespan < 0) {
			liveForever = true;
		}
		self.effects.add(this);
	}

	public function update(delta:Float) {
		if (!liveForever) {
			lifespan -= delta;
			
			if (lifespan < 0) {
				self.effects.remove(this);
			}
		}
	}

	public function canBeAdded():Bool {
		return true;
	}

	public function onEnter() {
	}

	public function onExit() {
	}
}
