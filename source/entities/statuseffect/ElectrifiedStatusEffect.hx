package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;
import elements.Element;

class ElectrifiedStatusEffect extends TimerTickingStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, frequency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, potency, frequency, lifespan);
		type = StatusEffect.Electrified;
	}

	override function onEnter() {
		super.onEnter();
		self.effects.add(new DazedStatusEffect(self, lifespan));
	}

	override function tick() {
		super.tick();
		self.effects.add(new HitStatusEffect(self, potency, Element.Electricity));
	}
}
