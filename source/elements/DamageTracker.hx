package elements;

import elements.Element;

class DamageTracker {
	public static var DAMAGE_REDUCE_SCALAR = 0.1; // reduces by this percentage every second

	private var damage:Map<Element, Float> = new Map<Element, Float>();

	public function new() {
	}

	public function update(delta:Float) {
		var netReducer = DAMAGE_REDUCE_SCALAR * delta;
		var dmg = 0.0;
		for (element in damage.keys()) {
			dmg = damage.get(element);
			damage.set(element, dmg - (dmg * netReducer));
		}
	}

	public function add(element:Element, damage:Float):Float {
		var netDamage = damage;
		if (this.damage.exists(element)) {
			netDamage += this.damage.get(element);
		}
		if (netDamage < 0.1) {
			netDamage = 0;
		}
		this.damage.set(element, netDamage);
		return netDamage;
	}

	public function set(element:Element, damage:Float):Float {
		var netDamage = damage;
		if (netDamage < 0.1) {
			netDamage = 0;
		}
		this.damage.set(element, netDamage);
		return netDamage;
	}

	public function get(element:Element):Float {
		if (!damage.exists(element)) {
			return 0;
		}
		return damage.get(element);
	}
}
