package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class ShatteredStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity) {
		super(self, 0);
		type = StatusEffect.Shattered;
	}

	override function canBeAdded():Bool {
		return self.effects.has(StatusEffect.Frozen);
	}

	override public function onEnter() {
		// damage to others needs to be controlled outside of this class
		self.effects.add(new DeathStatusEffect(self));
		// basically just hides the death animation because when you are shattered
		// a shattered sprite is created and a few pieces of ice are left where you were
		// and you cannot be seen anymore
		self.visible = false;
		// TODO: spawn shattering animation
	}
}
