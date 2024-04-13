package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class LoudStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, -1);
		type = StatusEffect.Loud;
	}

	override function onEnter() {
		super.onEnter();
		self.effects.removeByType(StatusEffect.Quiet);
	}
}
