package eu.ohmrun.halva.core;

typedef MemoDef<T> = {
  final value   : T;
  final frozen  : Bool;
}
@:using(halva.core.Memo.MemoLift)
abstract Memo<T>(MemoDef<T>) from MemoDef<T> to MemoDef<T>{
  static public var _(default,never) = MemoLift;
  public inline function new(self:MemoDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:MemoDef<T>):Memo<T> return new Memo(self);

  public function prj():MemoDef<T> return this;
  private var self(get,never):Memo<T>;
  private function get_self():Memo<T> return lift(this);
}
class MemoLift{
  static public inline function lift<T>(self:MemoDef<T>):Memo<T>{
    return Memo.lift(self);
  }
}