package entities.attacks.blasts;

import elements.Element;

class FireballBlast extends AreaBlast {
	public function new(x:Float, y:Float, radius:Float, potency:Float) {
		super(x, y, radius, potency, Element.Fire);
		loadGraphic(AssetPaths.explosion__png);
	}
}
