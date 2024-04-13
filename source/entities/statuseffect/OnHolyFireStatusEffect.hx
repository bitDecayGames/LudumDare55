package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;
import elements.Element;

class OnHolyFireStatusEffect extends TimerTickingStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, frequency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, potency, frequency, lifespan);
		type = StatusEffect.OnHolyFire;
	}

	override function canBeAdded():Bool {
		return !self.effects.has(StatusEffect.Wet);
	}

	override function onEnter() {
		super.onEnter();
		self.effects.removeByType(StatusEffect.Frozen);
	}

	override function tick() {
		super.tick();
		self.effects.add(new HitStatusEffect(self, potency, Element.Light));
	}
}
