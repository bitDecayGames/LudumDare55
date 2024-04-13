package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class TimerTickingStatusEffect extends BaseStatusEffect {
	public var frequency:Float = 0.5;
	private var curFreq:Float = 0.0;

	public function new(self:BaseEntity, potency:Float = 0.8, freqency:Float = 0.5, lifespan:Float = 1.0) {
		super(self, lifespan);
		this.potency = potency;
		this.frequency = freqency;
	}

	override function update(delta:Float) {
		super.update(delta);
		curFreq += delta;
		if (curFreq > frequency) {
			tick();
			curFreq = 0;
		}
	}

	public function tick() {

	}
}
