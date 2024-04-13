package entities.statemachine;

import entities.BaseEntity;

class BaseState {
	public var self:BaseEntity = null;

	public function new(self:BaseEntity) {
		this.self = self;
	}

	public function update(delta:Float):BaseState {

		return null;
	}

	public function onEnter(prev:BaseState):BaseState {

		return null;
	}

	public function onExit(next:BaseState):BaseState {

		return null;
	}
}
