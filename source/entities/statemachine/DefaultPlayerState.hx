package entities.statemachine;

import entities.statuseffect.ConfusedStatusEffect;
import input.SimpleController;
import input.InputCalcuator;
import entities.Player;

class DefaultPlayerState extends BaseState<Player> {
	public function new(self:Player) {
		super(self);
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		var inputDir = InputCalcuator.getInputCardinal(self.playerNum);
		if (inputDir != NONE) {
			var dir = inputDir.asVector();
			self.velocity.set(dir.x * self.speed, dir.y * self.speed);
		} else {
			self.velocity.set();
		}

		if (SimpleController.pressed(Button.A, self.playerNum)) {
			return cast new ClockState(self);
		}

		return null;
	}
}
