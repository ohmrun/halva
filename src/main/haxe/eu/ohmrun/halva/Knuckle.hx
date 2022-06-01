package eu.ohmrun.halva;

enum KnuckleSum{
  Ordinal(idx:UInt);
  Nominal(str:String);
}
@:using(eu.ohmrun.halva.Knuckle.KnuckleLift)
abstract Knuckle(KnuckleSum) from KnuckleSum to KnuckleSum{
  static public var _(default,never) = KnuckleLift;
  public inline function new(self:KnuckleSum) this = self;
  @:noUsing static inline public function lift(self:KnuckleSum):Knuckle return new Knuckle(self);

  public function prj():KnuckleSum return this;
  private var self(get,never):Knuckle;
  private function get_self():Knuckle return lift(this);

  @:from static public function fromUInt(self:UInt){
    return lift(Ordinal(self));
  }
  @:from static public function fromString(self:String){
    return lift(Nominal(self));
  }
}
class KnuckleLift{
  static public inline function lift(self:KnuckleSum):Knuckle{
    return Knuckle.lift(self);
  }
}