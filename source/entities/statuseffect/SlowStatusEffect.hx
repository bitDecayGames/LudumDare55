package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class SlowStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, lifespan:Float = 1.0, ownerId:Int = -1) {
		super(self, lifespan, ownerId);
		type = StatusEffect.Slow;
		this.potency = potency;
	}

	override public function onEnter() {
		self.speed *= potency;
	}

	override function onExit() {
		self.speed /= potency;
	}
}
