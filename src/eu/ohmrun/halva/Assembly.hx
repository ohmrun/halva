package eu.ohmrun.halva;

/**
  Models a progression form a (json/lisp/xml)+ structure with leaves of type `Data` to an assembled value of type `Item`
**/
enum AssemblySum<Data,Item>{
  Atomized(account:Account<Junction<Data>>);
  Realized(v:Item);
}

@:using(eu.ohmrun.halva.Assembly.AssemblyLift)
abstract Assembly<Data,Item>(AssemblySum<Data,Item>) from AssemblySum<Data,Item> to AssemblySum<Data,Item>{
  static public var _(default,never) = AssemblyLift;
  public inline function new(self:AssemblySum<Data,Item>) this = self;
  @:noUsing static inline public function lift<Data,Item>(self:AssemblySum<Data,Item>):Assembly<Data,Item> return new Assembly(self);

  public function prj():AssemblySum<Data,Item> return this;
  private var self(get,never):Assembly<Data,Item>;
  private function get_self():Assembly<Data,Item> return lift(this);
}
class AssemblyLift{
  static public inline function lift<Data,Item>(self:AssemblySum<Data,Item>):Assembly<Data,Item>{
    return Assembly.lift(self);
  }
}