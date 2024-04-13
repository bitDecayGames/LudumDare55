package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;
import elements.Element;

class PoisonedStatusEffect extends TimerTickingStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, frequency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, potency, frequency, lifespan);
		type = StatusEffect.Poisoned;
	}

	override function onEnter() {
		super.onEnter();
		// negated by healing effects
		if (self.effects.has(StatusEffect.Healing)) {
			self.effects.removeByType(StatusEffect.Healing);
			self.effects.remove(this);
		}
	}

	override function tick() {
		super.tick();
		self.effects.add(new HitStatusEffect(self, potency, Element.Poison));
	}
}
