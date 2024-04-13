package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class HasteStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, potency:Float = 1.2, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Haste;
		this.potency = potency;
	}

	override public function onEnter() {
		self.speed *= potency;
	}

	override function onExit() {
		self.speed /= potency;
	}
}
