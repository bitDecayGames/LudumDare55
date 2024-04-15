package entities;

import bitdecay.flixel.debug.DebugDraw;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.FlxG;
import entities.attacks.BaseAttack;

class BaseEnemy extends BaseEntity {

	public var currentAttack:BaseAttack;
	public var player:Player;
	public var vision:Float = 10;
	public var avoidFactor:Float = 30;
	public var avoidSize:Float = 20;

	public var projectileGroup:FlxSpriteGroup;
	public var enemyGroup:FlxSpriteGroup;

	public function new(X:Float, Y:Float, player:Player, projectileGroup: FlxSpriteGroup, enemyGroup: FlxSpriteGroup) {
		super(X, Y);
		this.player = player;
		this.projectileGroup = projectileGroup;
		this.enemyGroup = enemyGroup;
		// FlxG.debugger.addTrackerProfile(new TrackerProfile(BaseEnemy, ["speed", "velocity", "effects", "stateMachine"]));
		// FlxG.debugger.track(this, "Enemy");

	}

	override function update(delta:Float) {
		super.update(delta);
		var c = center();
		var m = FlxPoint.get(0, 0);
		if (targetEntity != null) {
			target = targetEntity.center();
		}
		if (target != null) {
			var diffToTarget = FlxPoint.get(target.x - c.x, target.y - c.y);
			if (diffToTarget.length > 10) {
				diffToTarget.normalize();
				m.add(diffToTarget.x, diffToTarget.y);
			}
		}
		var close = FlxPoint.get(0, 0);
		for (other in enemyGroup) {
			if (other != this) {
				var diff = FlxPoint.get(x - other.x, y - other.y);
				if (diff.length < avoidSize) {
					close.add(diff.x, diff.y);
				}
			}
		}
		close.normalize();
		close.scale(avoidFactor, avoidFactor);
		DebugDraw.ME.drawWorldLine(FlxG.camera, x, y, x + m.x*10, y + m.y*10, null, 0xff0000);
		DebugDraw.ME.drawWorldLine(FlxG.camera, x, y, x + close.x*10, y + close.y*10, null, 0x0000ff);
		m.add(close.x, close.y);
		move(m);
	}
}
