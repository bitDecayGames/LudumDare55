package entities.statuseffect;

import entities.BaseEntity;
import entities.statuseffect.StatusEffect;

class DifficultTerrainStatusEffect extends BaseStatusEffect {

	public function new(self:BaseEntity, potency:Float = 0.8, ownerId:Int = -1) {
		super(self, -1, ownerId);
		type = StatusEffect.DifficultTerrain;
		this.potency = potency;
	}

	override public function onEnter() {
		self.friction *= potency;
	}

	override function onExit() {
		self.friction /= potency;
	}
}
