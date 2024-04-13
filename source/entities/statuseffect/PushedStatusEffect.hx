package entities.statuseffect;

import flixel.math.FlxPoint;
import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class PushedStatusEffect extends BaseStatusEffect {
	public var direction:FlxPoint;
	public var netPotency:Float;

	public function new(self:BaseEntity, direction:FlxPoint, potency:Float = 1.0) {
		super(self, 0.0);
		type = StatusEffect.Pushed;
		this.direction = direction;
		this.potency = potency;
		netPotency = potency - (self.sturdiness * BaseEntity.sturdinessScalar);
		if (netPotency < 0) {
			netPotency = 0;
		}
	}

	override public function onEnter() {
		super.onEnter();
		self.velocity.add(direction.x * netPotency, direction.y * netPotency);
		if (self.sturdiness < potency) {
			// knocked down
			self.effects.add(new FallenStatusEffect(self));
		}
	}
}
