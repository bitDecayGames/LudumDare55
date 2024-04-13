package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class DeathStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, -1);
		type = StatusEffect.Dead;
	}

	override public function onEnter() {
		self.health = 0;
		self.canTarget = false;
		self.canAttack = false;
		self.canMove = false;
		self.canBeAttacked = false;
		self.canBeTargeted = false;
		self.canBeDamaged = false;

	}

	override function update(delta:Float) {
		super.update(delta);
		self.canTarget = false;
		self.canAttack = false;
		self.canMove = false;
		self.canBeAttacked = false;
		self.canBeTargeted = false;
		self.canBeDamaged = false;
	}

	override function onExit() {
		self.canTarget = true;
		self.canAttack = true;
		self.canMove = true;
		self.canBeAttacked = true;
		self.canBeTargeted = true;
		self.canBeDamaged = true;
	}
}
