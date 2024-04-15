package entities;

import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import elements.Element;
import flixel.FlxSprite;

import loaders.Aseprite;
import loaders.AsepriteMacros;

class SummonerClock extends FlxSpriteGroup {

	public static var elementOrderList = [
		Element.Fire,
		Element.Water,
		Element.Earth,
		Element.Wind,
		Element.Ice,
		Element.Metal,
		Element.Electricity,
		Element.Shadow,
		Element.Light,
		Element.Life,
	];

	private static var elementOffset = [
		1.0, // Element.Fire,
		0.95, // Element.Water,
		1.0, // Element.Earth,
		0.95, // Element.Wind,
		0.81, // Element.Ice,
		0.81, // Element.Metal,
		0.81, // Element.Electricity,
		0.81, // Element.Shadow,
		1.0, // Element.Light,
		1.0, // Element.Life,
	];

	private static var elementColor = [
		0xff0000, // Element.Fire,
		0x0000ff, // Element.Water,
		0x00ff00, // Element.Earth,
		0xffffff, // Element.Wind,
		0x0088dd, // Element.Ice,
		0xaaaaaa, // Element.Metal,
		0xffff00, // Element.Electricity,
		0x224488, // Element.Shadow,
		0xffaa44, // Element.Light,
		0x00aa55, // Element.Life,
	];
	
	private static var elementAssets = [
		AssetPaths.gem_fire__png, // Element.Fire,
		AssetPaths.gem_water__png, // Element.Water,
		AssetPaths.gem_earth__png, // Element.Earth,
		AssetPaths.gem_wind__png, // Element.Wind,
		AssetPaths.gem_ice__png, // Element.Ice,
		AssetPaths.gem_metal__png, // Element.Metal,
		AssetPaths.gem_electricity__png, // Element.Electricity,
		AssetPaths.gem_shadow__png, // Element.Shadow,
		AssetPaths.gem_light__png, // Element.Light,
		AssetPaths.gem_life__png, // Element.Life,
	];

	private var elementAccess = new Map<Element, Bool>();

	public var clockSprite:CenterableEntity;

	public var primary:Element = Element.None;
	public var primaryAngle:Float = 0.0;
	public var primarySprite:CenterableEntity;

	public var secondary:Element = Element.None;
	public var secondaryAngle:Float = 0.0;
	public var secondarySprite:CenterableEntity;

	public var gems:Map<Element, ClockGem> = new Map<Element, ClockGem>();

	private var animDur:Float = 0.15;
	private var animYOffset:Float = -10;
	private var originalY:Float = 0;
	private var tween:FlxTween;
	private var colorTween:FlxTween;

	public function new(x:Float, y:Float) {
		super(x, y);
		originalY = y;
		y = originalY - animYOffset;
		alpha = 0;

		clockSprite = new CenterableEntity(0, 0, AssetPaths.clock__png);
		add(clockSprite);
		primarySprite = new CenterableEntity(0, 0, AssetPaths.primary_hand__png);
		secondarySprite = new CenterableEntity(0, 0, AssetPaths.secondary_hand__png);


		var v = FlxPoint.get(0, -1);
		for (i in 0...elementOrderList.length) {
			var element = elementOrderList[i];
			var x = v.x * 100 * elementOffset[i];
			var y = v.y * 100 * elementOffset[i];
			var color = elementColor[i];
			var glow = new ClockGemGlow(x, y, color, AssetPaths.gem_glow__png);
			add(glow);
			var gem = new ClockGem(x, y, glow, elementAssets[i]);
			gem.visible = false;
			add(gem);
			gems.set(element, gem);
			v.rotateByDegrees(360 / 10.0);
		}

		add(primarySprite);
		add(secondarySprite);
		this.scale.set(2, 2);

		FlxG.debugger.addTrackerProfile(new TrackerProfile(SummonerClock, ["primary", "secondary"]));
		FlxG.debugger.track(this, "Clock");
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.watch.add(this, "primary");
		FlxG.watch.add(this, "secondary");

		primarySprite.angle = primaryAngle;
		secondarySprite.angle = secondaryAngle;

	}

	public function show() {
		if (tween != null) {
			tween.cancel();
		}
		if (colorTween != null) {
			colorTween.cancel();
		}
		tween = FlxTween.tween(this, {y: originalY}, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn});
		colorTween = FlxTween.num(0, 1, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));

		for (gem in gems) {
			gem.glow.visible = false;
			gem.glow.alpha = 0.0;
		}
	}

	public function hide() {
		if (tween != null) {
			tween.cancel();
		}
		if (colorTween != null) {
			colorTween.cancel();
		}
		tween = FlxTween.tween(this, {y: originalY-animYOffset}, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn});
		colorTween = FlxTween.num(1, 0, animDur, {type: FlxTweenType.PERSIST, ease: FlxEase.expoIn}, tweenFunction.bind(this));
	}

	function tweenFunction(s:FlxSprite, v:Float) {
		s.alpha = v;
	}
	
	public function addElement(element:Element) {
		elementAccess.set(element, true);

		if (gems.exists(element)) {
			var g = gems.get(element);
			g.visible = true;
		}
	}

	public function hasElement(element:Element):Bool {
		return elementAccess.exists(element) && elementAccess.get(element);
	}

	// getElement takes an angle that is relative to the normalized UP vector (0, -1)
	public function getElement(angle:Float):Element {
		// normalize the angle to the slightly offset rotation of the clock (counter clockwize 18 degrees)
		var index = getIndex(angle);
		var element = elementOrderList[index];
		if (!hasElement(element)) {
			return Element.None;
		}
		return element;
	}

	public function hideGlow(e:Element) {
		if (gems.exists(e)) {
			gems.get(e).glow.hide();
		}
	}

	public function getIndex(angle:Float):Int {
		if (angle < 0) {
			angle += 360;
		}
		return Math.floor(((angle + (360.0 / elementOrderList.length * 0.5)) % 360.0) / (360.0 / elementOrderList.length));
	}

	public function getNextElement(e:Element):Element {
		var index = -1;
		for (i in 0...elementOrderList.length) {
			if (elementOrderList[i] == e) {
				index = i;
				break;
			}
		}
		if (index == -1) {
			return None;
		}
		var foundIndex = index;
		var elem = e;
		index++;
		while(elem != e && foundIndex != index) {
			if (index >= elementOrderList.length) {
				index = 0;
			} else {
				var possible = elementOrderList[index];
				if (hasElement(possible)) {
					return possible;
				}
				index++;
			}
		} 

		return e;
	}
}

