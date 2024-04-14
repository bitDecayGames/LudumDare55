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
		clock = new SummonerClock(250, 100);
		player = new Player(200, 200, clock, projectileGroup);
		 
		add(clock);
		add(player);
		add(projectileGroup);

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
