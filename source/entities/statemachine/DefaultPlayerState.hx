package entities.statemachine;

import flixel.math.FlxPoint;
import entities.statuseffect.ConfusedStatusEffect;
import input.FullController;
import input.InputCalcuator;
import entities.Player;
import shaders.OutlineShader;

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
			if (self.currentAttack != null) {
				var center = self.center();
				var dir = FlxPoint.get(1, 0).rotateByDegrees(self.facingDegrees);
				if (self.currentAttack.started) {
					self.currentAttack.attackOrigin.set(center.x, center.y);
					self.currentAttack.attackDirection = dir;
				} else if (self.currentAttack.ready) {
					self.currentAttack.trigger(center.x, center.y, dir);
				}
			}
		} else if (self.currentAttack != null && self.currentAttack.started) {
			self.currentAttack.stop();
		}

		// Turning
		if (gamepad != null) {
			var right = FlxPoint.get(gamepad.analog.value.RIGHT_STICK_X, gamepad.analog.value.RIGHT_STICK_Y);
			if (right.length > 0.2) {
				self.facingTarget = right.degrees;
			}
		}

		// Shader debug
		if (FullController.justPressed(Button.X, self.playerNum)) {
			var shader = cast(self.shader, OutlineShader);
			shader.setEnabled(!shader.getEnabled());
		}
		if (FullController.justPressed(Button.Y, self.playerNum)) {
			var shader = cast(self.shader, OutlineShader);
			shader.setSize(shader.getWidth() + 1, shader.getHeight() + 1);
		}

		return null;
	}

	override function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.move(FlxPoint.get(0, 0));
		if (self.currentAttack != null && self.currentAttack.started) {
			self.currentAttack.stop();
		}
		return super.onExit(next);
	}
}
