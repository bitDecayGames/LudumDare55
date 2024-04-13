package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;
import elements.Element;

class WetStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, lifespan:Float = 1.0) {
		super(self, lifespan);
		type = StatusEffect.Wet;
	}

	override public function onEnter() {
		// TODO: tint sprite dark blue

		self.effects.removeByType(StatusEffect.OnFire);
		self.effects.removeByType(StatusEffect.OnHolyFire);

		self.resistance.add(Element.Fire, self.resistance.get(Element.Fire) * 0.8);
		self.resistance.add(Element.Electricity, self.resistance.get(Element.Electricity) * 1.8);
		self.resistance.add(Element.Ice, self.resistance.get(Element.Ice) * 1.8);
	}
	
	override function onExit() {
		// TODO: remove dark blue tint

		super.onExit();
		self.resistance.add(Element.Fire, self.resistance.get(Element.Fire) / 0.8);
		self.resistance.add(Element.Electricity, self.resistance.get(Element.Electricity) / 1.8);
		self.resistance.add(Element.Ice, self.resistance.get(Element.Ice) / 1.8);
	}
}
