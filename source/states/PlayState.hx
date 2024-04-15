package states;

import flixel.group.FlxSpriteGroup;
import entities.SummonerClock;
import entities.BaseEntity;
import entities.Item;
import flixel.util.FlxColor;
import debug.DebugLayers;
import achievements.Achievements;
import flixel.addons.transition.FlxTransitionableState;
import signals.Lifecycle;
import entities.Player;
import flixel.FlxSprite;
import flixel.FlxG;
import bitdecay.flixel.debug.DebugDraw;
import elements.Element;

using states.FlxStateExt;

class PlayState extends FlxTransitionableState {
	var player:BaseEntity;
	var clock:SummonerClock;
	var projectileGroup:FlxSpriteGroup;

	override public function create() {
		super.create();
		Lifecycle.startup.dispatch();

		FlxG.camera.pixelPerfectRender = true;

		projectileGroup = new FlxSpriteGroup();
		clock = new SummonerClock(FlxG.width / 2, FlxG.height / 2);
		player = new Player(200, 200, clock, projectileGroup);
		for (element in SummonerClock.elementOrderList) {
			clock.addElement(element);
		}
		 
		add(player);
		add(projectileGroup);

		add(clock);

		//add(Achievements.ACHIEVEMENT_NAME_HERE.toToast(true, true));

		QuickLog.error('Example error');
		FlxG.camera.bgColor = FlxColor.CYAN;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var cam = FlxG.camera;
		DebugDraw.ME.drawCameraRect(cam.getCenterPoint().x - 5, cam.getCenterPoint().y - 5, 10, 10, DebugLayers.RAYCAST, FlxColor.RED);
	}

	override public function onFocusLost() {
		super.onFocusLost();
		this.handleFocusLost();
	}

	override public function onFocus() {
		super.onFocus();
		this.handleFocus();
	}
}
