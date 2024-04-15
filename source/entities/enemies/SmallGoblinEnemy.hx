package entities.enemies;

import entities.statemachine.WatchfulState;
import entities.Player;
import flixel.group.FlxSpriteGroup;

class SmallGoblinEnemy extends BaseEnemy {
	public function new(X:Float, Y:Float, player:Player, projectileGroup: FlxSpriteGroup, enemyGroup: FlxSpriteGroup) {
		super(X, Y, player, projectileGroup, enemyGroup);

		maxHealth = 10;
		health = maxHealth;
		speed = 50;
		maxSpeed = speed * 2;
		naturalSpeed = speed;
		friction = 1000;
		sturdiness = 10;
		vision = 300;

		loadGraphic(AssetPaths.small_goblin__png);

		stateMachine.switchTo(cast new WatchfulState(this));
	}
}
