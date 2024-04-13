package entities.statemachine;

import entities.statemachine.BaseState;
import entities.BaseEntity;

class StateMachine {
	public var self:BaseEntity;
	public var current:BaseState;
	public var next:BaseState;
	public var prev:BaseState;
	private var tmp:BaseState;

	public function new(self:BaseEntity, initialState:BaseState = null) {
		next = initialState;
	}

	public function update(delta:Float) {
		if (current != null) {
			next = current.update(delta);
			switchTo(next);
		}
	}

	public function switchTo(next:BaseState) {
		if (next != null) {
			if (current != null) {
				current.onExit(next);
			}
			prev = current;
			current = next;
			this.next = null;
			current.onEnter(prev);
		}
	}
}
