package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class WetStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Wet;
	}

	override public function onEnter() {
		self.effects.removeByType(StatusEffect.OnFire);
		self.effects.removeByType(StatusEffect.OnHolyFire);
	}
}
