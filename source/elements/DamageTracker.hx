package elements;

import elements.Element;

class DamageTracker {
	private var damage:Map<Element, Float> = new Map<Element, Float>();

	public function new() {
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
