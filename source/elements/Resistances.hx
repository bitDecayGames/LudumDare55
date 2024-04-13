package elements;

import elements.Element;

class Resistances {
	private var resistances:Map<Element, Float> = new Map<Element, Float>();

	public function new() {
	}

	public function add(element:Element, resistance:Float):Float {
		var netResistance = resistance;
		if (resistances.exists(element)) {
			netResistance += resistances.get(element);
		}
		if (netResistance < 0) {
			netResistance = 0;
		}
		resistances.set(element, netResistance);
		return netResistance;
	}

	public function set(element:Element, resistance:Float):Float {
		var netResistance = resistance;
		if (netResistance < 0) {
			netResistance = 0;
		}
		resistances.set(element, netResistance);
		return netResistance;
	}

	public function get(element:Element):Float {
		if (!resistances.exists(element)) {
			return 1;
		}
		return resistances.get(element);
	}
}
