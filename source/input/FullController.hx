package input;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepad;

class FullController {
	static var keyboardBindings:Array<Map<Button, Array<FlxKey>>> = [
		// PLAYER ONE
		[
			UP => [FlxKey.UP, FlxKey.W],
			DOWN => [FlxKey.DOWN, FlxKey.S],
			LEFT => [FlxKey.LEFT, FlxKey.A],
			RIGHT => [FlxKey.RIGHT, FlxKey.D],
			A => [FlxKey.V, FlxKey.SPACE],
			B => [FlxKey.C, FlxKey.B, FlxKey.BACKSPACE],
			X => [FlxKey.Q],
			Y => [FlxKey.E],
			LEFT_BUMPER => [FlxKey.TAB],
			RIGHT_BUMPER => [FlxKey.R],
			START => [FlxKey.ENTER],
			BACK => [FlxKey.ESCAPE],
		],
		// PLAYER TWO
		[
			UP => [FlxKey.U],
			DOWN => [FlxKey.J],
			LEFT => [FlxKey.H],
			RIGHT => [FlxKey.K],
			A => [FlxKey.PERIOD],
			B => [FlxKey.SLASH],
			X => [FlxKey.Y],
			Y => [FlxKey.I],
			START => [FlxKey.QUOTE],
			BACK => [FlxKey.BACKSLASH],
		],
	];

	static var gamepadButtonBindings:Map<Button, Array<FlxGamepadInputID>> = [
		UP => [DPAD_UP],
		DOWN => [DPAD_DOWN],
		LEFT => [DPAD_LEFT],
		RIGHT => [DPAD_RIGHT],
		A => [A],
		B => [B],
		X => [X],
		Y => [Y],
		LEFT_BUMPER => [LEFT_SHOULDER],
		RIGHT_BUMPER => [RIGHT_SHOULDER],
		START => [START],
		BACK => [BACK],
	];

	static var gamepadAnalogBindings:Map<Analog, (g:FlxGamepad)->Float> = [
	    LEFT_STICK_X =>  (g) -> g.analog.value.LEFT_STICK_X,
	    LEFT_STICK_Y =>  (g) -> g.analog.value.LEFT_STICK_Y,
	    RIGHT_STICK_X => (g) -> g.analog.value.RIGHT_STICK_X,
	    RIGHT_STICK_Y => (g) -> g.analog.value.RIGHT_STICK_Y,
	    LEFT_TRIGGER =>  (g) -> g.analog.value.LEFT_TRIGGER,
	    RIGHT_TRIGGER => (g) -> g.analog.value.RIGHT_TRIGGER,
	];

	public static function pressed(button:Button, player:Int = 0):Bool {
		return pressedKey(button, player) || pressedPad(button, player);
	}

	static function pressedKey(button:Button, player:Int):Bool {
		return FlxG.keys.anyPressed(keyboardBindings[player][button]);
	}

	static function pressedPad(button:Button, player:Int):Bool {
		var gamepad = getGamepad(player);
		if (gamepad == null)
			return false;
		return gamepad.anyPressed(gamepadButtonBindings[button]);
	}

	public static function justPressed(button:Button, player:Int = 0):Bool {
		return justPressedKey(button, player) || justPressedPad(button, player);
	}

	static function justPressedKey(button:Button, player:Int):Bool {
		return FlxG.keys.anyJustPressed(keyboardBindings[player][button]);
	}

	static function justPressedPad(button:Button, player:Int):Bool {
		var gamepad = getGamepad(player);
		if (gamepad == null)
			return false;
		return gamepad.anyJustPressed(gamepadButtonBindings[button]);
	}

	public static function justReleased(button:Button, player:Int = 0):Bool {
		return justReleasedKey(button, player) || justReleasedPad(button, player);
	}

	static function justReleasedKey(button:Button, player:Int):Bool {
		return FlxG.keys.anyJustReleased(keyboardBindings[player][button]);
	}

	static function justReleasedPad(button:Button, player:Int):Bool {
		var gamepad = getGamepad(player);
		if (gamepad == null)
			return false;
		return gamepad.anyJustReleased(gamepadButtonBindings[button]);
	}

	public static function analog(analog:Analog, player:Int):Float {
		var gamepad = getGamepad(player);
		if (gamepad == null)
			return 0.0;
		return gamepadAnalogBindings[analog](gamepad);
	}


	public static function getGamepad(player:Int):FlxGamepad {
		var gamepads = FlxG.gamepads.getActiveGamepads();
		if (gamepads.length < player || gamepads[player] == null) {
			return null;
		}
		return gamepads[player];
	}
}

enum Button {
	UP;
	DOWN;
	LEFT;
	RIGHT;
	A;
	B;
	X;
	Y;
	START;
	BACK;
	LEFT_BUMPER;
	RIGHT_BUMPER;
}

enum ButtonState {
	JUST_PRESSED;
	PRESSED;
	JUST_RELEASED;
}

enum Analog {
	LEFT_STICK_X;
	LEFT_STICK_Y;
	RIGHT_STICK_X;
	RIGHT_STICK_Y;
	LEFT_TRIGGER;
	RIGHT_TRIGGER;
}
