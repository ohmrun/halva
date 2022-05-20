package eu.ohmrun.halva;

enum DeclSum{
  HDSchema(s:Schema);
	HDSType(t:SType);
	HDLiteral(x:Spine<Primitive>);
}
@:using(eu.ohmrun.halva.Decl.DeclLift)
abstract Decl(DeclSum) from DeclSum to DeclSum{
  static public var _(default,never) = DeclLift;
  public inline function new(self:DeclSum) this = self;
  @:noUsing static inline public function lift(self:DeclSum):Decl return new Decl(self);

  public function prj():DeclSum return this;
  private var self(get,never):Decl;
  private function get_self():Decl return lift(this);
}
class DeclLift{
  static public inline function lift(self:DeclSum):Decl{
    return Decl.lift(self);
  }
}