package entities.statuseffect;

import elements.Element;
import flixel.math.FlxPoint;
import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class HitStatusEffect extends BaseStatusEffect {
	public static var FROZEN_DAMAGE_THRESHOLD:Float = 100;
	public static var FIRE_DAMAGE_THRESHOLD:Float = 100;
	public static var BLEED_DAMAGE_THRESHOLD:Float = 100;
	public static var FALL_DAMAGE_THRESHOLD:Float = 100;
	public static var WET_DAMAGE_THRESHOLD:Float = 30;

	public var damageType:Element;

	public function new(self:BaseEntity, potency:Float, damageType:Element) {
		super(self, 0.05);
		type = StatusEffect.Hit;
		this.potency = potency;
		this.damageType = damageType;
	}

	override function canBeAdded():Bool {
		return self.canBeDamaged && self.resistance.get(damageType) > 0;
	}

	override public function onEnter() {
		super.onEnter();
		// TODO: tint sprite red
		var netDamage = potency * self.resistance.get(damageType);
		self.health -= netDamage;

		var totalDamage = self.damage.add(damageType, netDamage);

		self.effects.removeByType(StatusEffect.Invisible);
		switch (damageType) {
			case Fire:
				self.effects.removeByType(StatusEffect.Frozen);

				if (totalDamage > FIRE_DAMAGE_THRESHOLD) {
					self.effects.add(new OnFireStatusEffect(self, potency * 0.1));
				}
			case Water:
				self.effects.removeByType(StatusEffect.OnFire);
				self.effects.removeByType(StatusEffect.OnHolyFire);
				
				if (totalDamage > WET_DAMAGE_THRESHOLD) {
					self.effects.add(new WetStatusEffect(self));
				}
			case Earth:
				if (self.effects.has(StatusEffect.Frozen)) {
					self.effects.add(new ShatteredStatusEffect(self));
				}
				if (totalDamage > FALL_DAMAGE_THRESHOLD) {
					self.effects.add(new FallenStatusEffect(self));
				}
			case Metal:
				if (self.effects.has(StatusEffect.Frozen)) {
					self.effects.add(new ShatteredStatusEffect(self));
				}
				if (totalDamage > BLEED_DAMAGE_THRESHOLD) {
					self.effects.add(new BleedingStatusEffect(self));
				}
			case Ice:
				if (totalDamage > FROZEN_DAMAGE_THRESHOLD) {
					self.effects.add(new FrozenStatusEffect(self));
				}
			default:
				// do nothing special
		}
		
	}

	override function onExit() {
		super.onExit();
		// TODO: remove red tint
	}
}
