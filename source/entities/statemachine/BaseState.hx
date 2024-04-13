package entities.statemachine;

import entities.BaseEntity;

class BaseState<T:BaseEntity> {
	public var self:T = null;

	public function new(self:T) {
		this.self = self;
	}

	public function update(delta:Float):BaseState<BaseEntity> {

		return null;
	}

	public function onEnter(prev:BaseState<BaseEntity>):BaseState<BaseEntity> {

		return null;
	}

	public function onExit(next:BaseState<BaseEntity>):BaseState<BaseEntity> {

		return null;
	}

	public function toString():String {
		var p = Type.getClassName(Type.getClass(this)).split(".");
		if (p.length > 0) {
			return p[p.length - 1];
		}
		return "?State";
	}
}
