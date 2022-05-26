package eu.ohmrun.halva;

/**
  List-like structure with an option to close `(Bound)`
**/
enum AccountSum<T>{
  Spare;
  Extra(v:T,rest:Account<T>);
  Bound;
}
@:using(eu.ohmrun.halva.Account.AccountLift)
abstract Account<T>(AccountSum<T>) from AccountSum<T> to AccountSum<T>{
  static public var _(default,never) = AccountLift;
  public inline function new(self:AccountSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:AccountSum<T>):Account<T> return new Account(self);

  public function prj():AccountSum<T> return this;
  private var self(get,never):Account<T>;
  private function get_self():Account<T> return lift(this);

  @:noUsing static public function unit<T>(){       return Spare; }
  @:noUsing static public function pure<T>(v:T){    return Extra(v,Spare); }
  @:noUsing static public function once<T>(v:T){    return Extra(v,Bound); }
  static public function tuple<T>(l:T,r:T){
    return Extra(l,Extra(r,Bound));
  }
}
class AccountLift{
  static public inline function lift<T>(self:AccountSum<T>):Account<T>{
    return Account.lift(self);
  }
}