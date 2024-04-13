package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class EtherealStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Ethereal;
	}

	override public function onEnter() {
		self.canBeTargeted = false;
	}

	override function update(delta:Float) {
		super.update(delta);
		self.canBeTargeted = false;
	}

	override function onExit() {
		self.canBeTargeted = true;
	}
}
