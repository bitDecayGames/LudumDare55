package entities.statemachine;

class WatchfulState extends BaseState<BaseEnemy> {
	public function new(self:BaseEnemy) {
		super(self);
	}

	override function onEnter(prev:BaseState<BaseEntity>):BaseState<BaseEntity> {
		self.targetEntity = null;
		self.target = null;
		return null;
	}

	override function update(delta:Float):BaseState<BaseEntity> {
		var p = self.player.getPosition();
		var me = self.getPosition();
		if (me.distanceTo(p) < self.vision) {
			return cast new ChaseState(self);
		}
		return null;
	}
}
