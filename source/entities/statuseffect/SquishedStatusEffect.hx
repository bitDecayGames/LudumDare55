package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class SquishedStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, 0);
		type = StatusEffect.Squished;
	}

	override public function onEnter() {
		// damage to others needs to be controlled outside of this class
		self.effects.add(new DeathStatusEffect(self));
		// basically just hides the death animation because when you are squished
		// a squished sprite is created and is left where you were
		// and you cannot be seen anymore
		self.visible = false;
	}
}
