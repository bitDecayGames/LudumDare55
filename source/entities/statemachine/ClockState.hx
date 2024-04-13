package entities.statemachine;

import entities.statuseffect.ConfusedStatusEffect;
import input.SimpleController;
import input.InputCalcuator;
import entities.Player;

class ClockState extends BaseState<Player> {
	public function new(self:Player) {
		super(self);
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		if (!SimpleController.pressed(Button.A, self.playerNum)) {
			return cast new DefaultPlayerState(self);
		}
		return null;
	}

	override function onEnter(prev:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.clock.show();
		return null;
	}

	override function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.clock.hide();
		return null;
	}
}
