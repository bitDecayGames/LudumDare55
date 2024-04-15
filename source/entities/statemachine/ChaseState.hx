package entities.statemachine;

import flixel.math.FlxPoint;
import shaders.OutlineShader;

class ChaseState extends BaseState<BaseEnemy> {
	public function new(self:BaseEnemy) {
		super(self);
	}

	override function onEnter(prev:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.targetEntity = self.player;
		return null;
	}

	override function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.targetEntity = null;
		self.target = null;
		return null;
	}
}
