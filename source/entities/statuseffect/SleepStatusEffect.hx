package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class SleepStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Asleep;
	}

	override public function onEnter() {
		self.canTarget = false;
		self.canAttack = false;
		self.canMove = false;
	}

	override function update(delta:Float) {
		super.update(delta);
		self.canTarget = false;
		self.canAttack = false;
		self.canMove = false;
	}

	override function onExit() {
		self.canTarget = true;
		self.canAttack = true;
		self.canMove = true;
	}
}
