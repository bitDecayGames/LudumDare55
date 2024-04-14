package entities.statemachine;

import js.html.Element;
import flixel.FlxG;
import elements.Element;
import flixel.math.FlxPoint;
import input.FullController;
import entities.Player;

class ClockState extends BaseState<Player> {
	private var primaryIndex:Int = -1;
	private var secondaryIndex:Int = -1;

	public function new(self:Player) {
		super(self);
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		if (!FullController.pressed(Button.LEFT_BUMPER, self.playerNum) && !FullController.pressed(Button.RIGHT_BUMPER, self.playerNum)) {
			return cast new DefaultPlayerState(self);
		}
		var gamepad = FullController.getGamepad(self.playerNum);
		if (gamepad != null) {
			var left = FlxPoint.get(gamepad.analog.value.LEFT_STICK_X, gamepad.analog.value.LEFT_STICK_Y);
			if (left.length > 0.2) {
				var leftAngle = left.degrees + 90;
				primaryIndex = self.clock.getIndex(leftAngle);
				self.clock.primaryAngle = primaryIndex * (360 / SummonerClock.elementOrderList.length);
				var newPrimary = self.clock.getElement(leftAngle);
				if (self.clock.primary != newPrimary) {
					if (self.clock.gems.exists(self.clock.primary)) {
						self.clock.gems.get(self.clock.primary).glow.hide();
					}
					if (self.clock.gems.exists(newPrimary)) {
						self.clock.gems.get(newPrimary).glow.show();
					}
				}
				self.clock.primary = newPrimary;
			}
			var right = FlxPoint.get(gamepad.analog.value.RIGHT_STICK_X, gamepad.analog.value.RIGHT_STICK_Y);
			if (right.length > 0.2) {
				var rightAngle = right.degrees + 90;
				secondaryIndex = self.clock.getIndex(rightAngle);
				self.clock.secondaryAngle = secondaryIndex * (360 / SummonerClock.elementOrderList.length);
				var newSecondary = self.clock.getElement(rightAngle);
				if (self.clock.secondary != newSecondary) {
					if (self.clock.gems.exists(self.clock.secondary)) {
						self.clock.gems.get(self.clock.secondary).glow.hide();
					}
					if (self.clock.gems.exists(newSecondary)) {
						self.clock.gems.get(newSecondary).glow.show();
					}
				}
				self.clock.secondary = newSecondary;
			}
		}

		if (FullController.justPressed(Button.UP)) {
			self.clock.addElement(Element.Fire);
		}
		if (FullController.justPressed(Button.RIGHT)) {
			self.clock.addElement(Element.Water);
		}
		if (FullController.justPressed(Button.DOWN)) {
			self.clock.addElement(Element.Metal);
		}
		if (FullController.justPressed(Button.LEFT)) {
			self.clock.addElement(Element.Light);
		}
		return null;
	}

	override function onEnter(prev:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.clock.show();
		return null;
	}

	override function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.clock.hide();
		if (primaryIndex < 0) {
			self.clock.primary = Element.Bleed;
		}
		if (secondaryIndex < 0) {
			self.clock.secondary = Element.Poison;
		}
		return null;
	}
}
