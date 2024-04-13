package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class InvisibleStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Invisible;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.OnFire) && !self.effects.has(StatusEffect.OnHolyFire);
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
