package entities.statuseffect;

import entities.statuseffect.StatusEffect;
import entities.statuseffect.BaseStatusEffect;
import entities.BaseEntity;

class StatusEffects {
	public var self:BaseEntity;
	public var effects = new List<BaseStatusEffect>();
	public var toAdd = new List<BaseStatusEffect>();
	public var toRemove = new List<BaseStatusEffect>();

	public function new(self:BaseEntity) {
		this.self = self;
	}

	public function update(delta:Float) {
		if (toRemove.length > 0) {
			for (item in toRemove) {
				item.onExit();
				effects.remove(item);
			}
		}
		if (toAdd.length > 0) {
			for (item in toAdd) {
				if (item.canBeAdded()) {
					effects.add(item);
					item.onEnter();
				}
			}
		}
		
		for (item in effects) {
			item.update(delta);
		}
	}

	public function add(e:BaseStatusEffect) {
		toAdd.add(e);
	}

	public function remove(e:BaseStatusEffect) {
		toRemove.add(e);
	}

	public function removeByType(s:StatusEffect) {
		for (item in effects) {
			if (item.type == s) {
				remove(item);
			}
		}
	}

	public function removeByOwner(ownerId:Int) {
		for (item in effects) {
			if (item.ownerId == ownerId) {
				remove(item);
			}
		}
	}

	public function has(s:StatusEffect):Bool {
		for (item in effects) {
			if (item.type == s) {
				return true;
			}
		}
		return false;
	}
}
