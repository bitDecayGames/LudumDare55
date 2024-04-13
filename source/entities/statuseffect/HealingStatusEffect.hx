package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class HealingStatusEffect extends TimerTickingStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, frequency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, potency, frequency, lifespan);
		type = StatusEffect.Healing;
	}

	override function onEnter() {
		super.onEnter();
		// negated by poison effects
		if (self.effects.has(StatusEffect.Poisoned)) {
			self.effects.removeByType(StatusEffect.Poisoned);
			self.effects.remove(this);
		}

		// stops bleeding effects
		if (self.effects.has(StatusEffect.Bleeding)) {
			self.effects.removeByType(StatusEffect.Bleeding);
		}
	}

	override function tick() {
		super.tick();
		self.health += potency;
	}
}
