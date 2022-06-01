package eu.ohmrun.halva;

enum LVarSum<T>{
  BOT;
  HAS(v:T);
  TOP;
} 
@:using(eu.ohmrun.halva.LVar.LVarLift)
abstract LVar<T>(LVarSum<T>) from LVarSum<T> to LVarSum<T>{
  static public var _(default,never) = LVarLift;
  public inline function new(self:LVarSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:LVarSum<T>):LVar<T> return new LVar(self);

  public function prj():LVarSum<T> return this;
  private var self(get,never):LVar<T>;
  private function get_self():LVar<T> return lift(this);
}
class LVarLift{
  static public inline function lift<T>(self:LVarSum<T>):LVar<T>{
    return LVar.lift(self);
  }
} 