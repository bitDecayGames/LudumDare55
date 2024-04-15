package entities.statemachine;

import flixel.math.FlxPoint;
import shaders.OutlineShader;

class AttackState extends BaseState<BaseEnemy> {
	public function new(self:BaseEnemy) {
		super(self);
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		return null;
	}

	override function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.move(FlxPoint.get(0, 0));
		if (self.currentAttack != null && self.currentAttack.started) {
			self.currentAttack.stop();
		}
		return super.onExit(next);
	}
}
