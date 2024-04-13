package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class ImperviousStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Impervious;
	}

	override public function onEnter() {
		self.canBeDamaged = false;
	}

	override function update(delta:Float) {
		super.update(delta);
		self.canBeDamaged = false;
	}

	override function onExit() {
		self.canBeDamaged = true;
	}
}
