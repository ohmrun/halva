package eu.ohmrun.halva;

typedef AccountDef<T> = LinkedList<Journal<T>>;

@:using(eu.ohmrun.halva.Account.AccountLift)
@:forward abstract Account<T>(AccountDef<T>) from AccountDef<T> to AccountDef<T>{
  static public var _(default,never) = AccountLift;
  public inline function new(self:AccountDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:AccountDef<T>):Account<T> return new Account(self);
  @:noUsing static inline public function unit<T>(){
    return lift(Nil);
  }
  public function prj():AccountDef<T> return this;
  private var self(get,never):Account<T>;
  private function get_self():Account<T> return lift(this);
}
class AccountLift{

}