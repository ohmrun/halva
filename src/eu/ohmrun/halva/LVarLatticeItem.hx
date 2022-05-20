package eu.ohmrun.halva;

enum LVarLatticeItemSum<T>{
  LVTop;
  LvNode(v:T);
  LvBottom;
}
abstract LVarLatticeItem<T>(LVarLatticeItemSum<T>) from LVarLatticeItemSum<T> to LVarLatticeItemSum<T>{
  public function new(self) this = self;
  @:noUsing static public function lift<T>(self:LVarLatticeItemSum<T>):LVarLatticeItem<T> return new LVarLatticeItem(self);

  public function prj():LVarLatticeItemSum<T> return this;
  private var self(get,never):LVarLatticeItem<T>;
  private function get_self():LVarLatticeItem<T> return lift(this);
}