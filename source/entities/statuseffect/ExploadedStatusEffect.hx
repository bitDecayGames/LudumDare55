package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class ExploadedStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, 0);
		type = StatusEffect.Exploaded;
	}

	override public function onEnter() {
		// damage to others needs to be controlled outside of this class
		self.effects.add(new DeathStatusEffect(self));
		// basically just hides the death animation because when you are exploaded
		// an explosion sprite is created and a burnt spot is left where you were
		// and you cannot be seen anymore
		self.visible = false;
	}
}
