package states;

import flixel.math.FlxRandom;
import entities.Projectile;
import entities.BaseEnemy;
import entities.enemies.SmallGoblinEnemy;
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
	var player:Player;
	var clock:SummonerClock;
	var projectileGroup:FlxSpriteGroup;
	var enemyProjectileGroup:FlxSpriteGroup;
	var enemyGroup:FlxSpriteGroup;
	var rnd:FlxRandom;
	var t:Float = 0;
	var spawnTime:Float = 1;

	override public function create() {
		super.create();
		DebugDraw.init(Type.allEnums(DebugLayers));
		Lifecycle.startup.dispatch();

		FlxG.camera.pixelPerfectRender = true;
		rnd = new FlxRandom();

		projectileGroup = new FlxSpriteGroup();
		enemyProjectileGroup = new FlxSpriteGroup();
		enemyGroup = new FlxSpriteGroup();

		clock = new SummonerClock(FlxG.width / 2, FlxG.height / 2);
		player = new Player(FlxG.width/2, FlxG.height/2, clock, projectileGroup);
		for (element in SummonerClock.elementOrderList) {
			clock.addElement(element);
		}

		var x = 200;
		var y = 50;
		for (i in 0...10) {
			enemyGroup.add(new SmallGoblinEnemy(x + i * 30, y, player, enemyProjectileGroup, enemyGroup));
			enemyGroup.add(new SmallGoblinEnemy(x + i * 30, y + 30, player, enemyProjectileGroup, enemyGroup));
			enemyGroup.add(new SmallGoblinEnemy(x + i * 30, y + 60, player, enemyProjectileGroup, enemyGroup));
		}
		 
		add(player);
		add(enemyGroup);
		add(projectileGroup);
		add(enemyProjectileGroup);
		add(clock);

		//add(Achievements.ACHIEVEMENT_NAME_HERE.toToast(true, true));

		QuickLog.error('Example error');
		FlxG.camera.bgColor = FlxColor.CYAN;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		var cam = FlxG.camera;
		DebugDraw.ME.drawCameraRect(cam.getCenterPoint().x - 5, cam.getCenterPoint().y - 5, 10, 10, DebugLayers.RAYCAST, FlxColor.RED);

		FlxG.collide(projectileGroup, enemyGroup, (projectile, enemy) -> {
			collideProjectileToEnemy(cast projectile, cast enemy);
		});
		FlxG.collide(enemyGroup, player, (enemy, player) -> {
			collideEnemyToPlayer(cast enemy, cast player);
		});
		FlxG.collide(enemyProjectileGroup, player, (projectile, player) -> {
			collideProjectileToPlayer(cast projectile, cast player);
		});

		t -= elapsed;
		if (t < 0) {
			t = spawnTime;
			spawnOffscreen();
		}

	}

	public function spawnOffscreen() {
		enemyGroup.add(new SmallGoblinEnemy(rnd.float(0, FlxG.width), 0, player, enemyProjectileGroup, enemyGroup)); 

	}

	public function collideProjectileToEnemy(p:Projectile, e:BaseEnemy) {
		p.hit(e);
	}
	
	public function collideProjectileToPlayer(p:Projectile, player:Player) {
		p.hit(player);
	}
	
	public function collideEnemyToPlayer(e:BaseEnemy, player:Player) {
		//player.hurt(1);
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
