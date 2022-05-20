package eu.ohmrun.halva;

abstract LVarLatticeOps<T>(LVarLatticeOpsApi<T>) from LVarLatticeOpsApi<T> to LVarLatticeOpsApi<T>{
	public function new(self) this = self;
	@:noUsing static public function lift<T>(self:LVarLatticeOpsApi<T>):LVarLatticeOps<T> return new LVarLatticeOps(self);

	public function prj():LVarLatticeOpsApi<T> return this;
	private var self(get,never):LVarLatticeOps<T>;
	private function get_self():LVarLatticeOps<T> return lift(this);
}
interface LVarLatticeOpsApi<T>{
	public function unit():LVarLatticeData<T>;

	public function meet(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>;
	public function join(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>;
	public function toLVarLattice():LVarLatticeOps<T>;
}
abstract class LVarLatticeOpsCls<T> implements LVarLatticeOpsApi<T>{
	abstract public function meet(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>;
	abstract public function join(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>;
	public function toLVarLattice():LVarLatticeOps<T>{
		return this;
	}
}