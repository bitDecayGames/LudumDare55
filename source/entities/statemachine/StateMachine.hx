package entities.statemachine;

import entities.statemachine.BaseState;
import entities.BaseEntity;

class StateMachine<T:BaseEntity> {
	public var self:T;
	public var current:BaseState<BaseEntity>;
	public var next:BaseState<BaseEntity>;
	public var prev:BaseState<BaseEntity>;
	private var tmp:BaseState<BaseEntity>;

	public function new(self:T, initialState:BaseState<BaseEntity> = null) {
		this.self = self;
		next = initialState;
	}

	public function update(delta:Float) {
		if (current != null) {
			next = current.update(delta);
			switchTo(next);
		}
	}

	public function switchTo(next:BaseState<BaseEntity>) {
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

	public function toString():String {
		if (current != null) {
			return current.toString();
		}
		return "?Null";
	}
}
