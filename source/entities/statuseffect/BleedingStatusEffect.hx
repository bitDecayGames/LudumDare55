package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;
import elements.Element;

class BleedingStatusEffect extends TimerTickingStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, frequency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, potency, frequency, lifespan);
		type = StatusEffect.Bleeding;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Healing);
	}

	override function tick() {
		super.tick();
		self.effects.add(new HitStatusEffect(self, potency, Element.Bleed));
	}
}
