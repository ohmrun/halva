package eu.ohmrun.halva;

enum JunctionSum<T>{
  There(r:Register);
  Whole(v:T);
}
@:using(eu.ohmrun.halva.Junction.JunctionLift)
abstract Junction<T>(JunctionSum<T>) from JunctionSum<T> to JunctionSum<T>{
  static public var _(default,never) = JunctionLift;
  public inline function new(self:JunctionSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:JunctionSum<T>):Junction<T> return new Junction(self);

  public function prj():JunctionSum<T> return this;
  private var self(get,never):Junction<T>;
  private function get_self():Junction<T> return lift(this);
}
class JunctionLift{
  static public inline function lift<T>(self:JunctionSum<T>):Junction<T>{
    return Junction.lift(self);
  }
}