package entities;

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

	private var elementAccess = new Map<Element, Bool>();

	public var clockSprite:FlxSprite;

	public var primary:Element = Element.None;
	public var primaryAngle:Float = 0.0;
	public var primarySprite:FlxSprite;

	public var secondary:Element = Element.None;
	public var secondaryAngle:Float = 0.0;
	public var secondarySprite:FlxSprite;

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

		clockSprite = new FlxSprite(0, 0, AssetPaths.clock__png);
		add(clockSprite);
		primarySprite = new FlxSprite(0, 0, AssetPaths.primary_hand__png);
		add(primarySprite);
		secondarySprite = new FlxSprite(0, 0, AssetPaths.secondary_hand__png);
		add(secondarySprite);

		for (i in 0...elementOrderList.length) {
			var element = elementOrderList[i];
			var x = 0 + (i * 10);
			var y = 0;
			var glow = new ClockGemGlow(x, y);
			glow.visible = false;
			add(glow);
			var gem = new ClockGem(x, y, glow);
			gem.visible = false;
			add(gem);
			gems.set(element, gem);
		}

		this.scale.set(2, 2);
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
			gems.get(element).visible = true;
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

