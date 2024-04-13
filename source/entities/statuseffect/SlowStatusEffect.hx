package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class SlowStatusEffect extends BaseStatusEffect {
	public var potency:Float = 0.8;

	public function new(self:BaseEntity, potency:Float = 0.8, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Slow;
	}

	override public function onEnter() {
		self.speed *= potency;
	}

	override function onExit() {
		self.speed /= potency;
	}
}
