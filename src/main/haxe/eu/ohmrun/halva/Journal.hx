package eu.ohmrun.halva;

enum JournalSum<T>{
  Record(knuckle:Knuckle,account:Junction<Account<Journal<T>>>);
  Figure(figure:LVar<T>);//Figure(TOP) acts as a boundary
}
@:using(eu.ohmrun.halva.Journal.JournalLift)
abstract Journal<T>(JournalSum<T>) from JournalSum<T> to JournalSum<T>{
  static public var _(default,never) = JournalLift;
  public inline function new(self:JournalSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:JournalSum<T>):Journal<T> return new Journal(self);

  public function prj():JournalSum<T> return this;
  private var self(get,never):Journal<T>;
  private function get_self():Journal<T> return lift(this);
}
class JournalLift{
  static public inline function lift<T>(self:JournalSum<T>):Journal<T>{
    return Journal.lift(self);
  }
}