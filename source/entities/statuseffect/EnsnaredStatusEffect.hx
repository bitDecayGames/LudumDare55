package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class EnsnaredStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Ensnared;
	}

	override public function onEnter() {
		self.canMove = false;
	}

	override function update(delta:Float) {
		super.update(delta);
		self.canMove = false;
	}

	override function onExit() {
		self.canMove = true;
	}
}
