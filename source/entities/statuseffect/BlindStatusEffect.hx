package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class BlindStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Blind;
	}

	override public function onEnter() {
		self.canTarget = false;
		self.canAttack = false;
	}

	override function update(delta:Float) {
		super.update(delta);
		self.canTarget = false;
		self.canAttack = false;
	}

	override function onExit() {
		self.canTarget = true;
		self.canAttack = true;
	}
}
