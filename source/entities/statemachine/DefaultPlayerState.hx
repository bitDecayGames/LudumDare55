package entities.statemachine;

import flixel.math.FlxPoint;
import entities.statuseffect.ConfusedStatusEffect;
import input.FullController;
import input.InputCalcuator;
import entities.Player;

class DefaultPlayerState extends BaseState<Player> {
	public function new(self:Player) {
		super(self);
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		var inputDir = InputCalcuator.getInputCardinal(self.playerNum);
		var gamepad = FullController.getGamepad(self.playerNum);

		// Movement
		if (inputDir != NONE) {
			var dir = inputDir.asVector();
			self.move(dir);
		} else if (gamepad != null) {
			var left = FlxPoint.get(gamepad.analog.value.LEFT_STICK_X, gamepad.analog.value.LEFT_STICK_Y);
			if (left.length > .2) {
				self.move(left);
			} else {
				self.move(FlxPoint.get(0, 0));
			}
		} else {
			self.move(FlxPoint.get(0, 0));
		}

		// Bring up Clock
		if (FullController.pressed(Button.LEFT_BUMPER, self.playerNum) || FullController.pressed(Button.RIGHT_BUMPER, self.playerNum)) {
			return cast new ClockState(self);
		}

		// Attack
		if (FullController.pressed(Button.A, self.playerNum) || FullController.analog(Analog.RIGHT_TRIGGER, self.playerNum) >= .8 || FullController.analog(Analog.LEFT_TRIGGER, self.playerNum) >= .8) {
			if (self.currentAttack != null && self.currentAttack.ready) {
				var center = self.center();
				self.currentAttack.trigger(center.x, center.y, FlxPoint.get(1, 0).rotateByDegrees(self.facingDegrees));
			}
		}

		// Turning
		if (gamepad != null) {
			var right = FlxPoint.get(gamepad.analog.value.RIGHT_STICK_X, gamepad.analog.value.RIGHT_STICK_Y);
			if (right.length > 0.2) {
				self.facingTarget = right.degrees;
			}
		}

		return null;
	}
}
