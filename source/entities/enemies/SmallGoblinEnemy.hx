package entities.enemies;

import entities.statemachine.DefaultEnemyState;
import entities.Player;
import flixel.group.FlxSpriteGroup;

class SmallGoblinEnemy extends BaseEnemy {
	public function new(X:Float, Y:Float, player:Player, projectileGroup: FlxSpriteGroup) {

		maxHealth = 10;
		speed = 10;
		maxSpeed = 15;
		naturalSpeed = speed;
		friction = 1000;
		sturdiness = 10;

		super(X, Y, maxHealth, player, projectileGroup);

		loadGraphic(AssetPaths.small_goblin__png);

		stateMachine.switchTo(cast new DefaultEnemyState(this));
	}
}
