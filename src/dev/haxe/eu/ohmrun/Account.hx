package eu.ohmrun.halva;

typedef AccountDef<T> = LinkedList<Journal<T>>;

class AccountCtr<T> extends Clazz{
  public function Make(head:CTR<JournalCtr<T>,Journal<T>>,next:CTR<AccountCtr<T>,Account<T>>):Account<T>{
    return Cons(head.apply(new JournalCtr()),next.apply(this));
  }
  public function Figure(lvar:LVar<T>):Account<T>{
    return Account.lift(Cons(JournalSum.Figure(lvar),Nil));
  }
  public function Bottom():Account<T>{
    return Account.lift(Cons(JournalSum.Figure(BOT),Nil));
  }
  public function Top():Account<T>{
    return Account.lift(Cons(JournalSum.Figure(TOP),Nil));
  }
  //public function Placement(rest)
}
@:using(eu.ohmrun.halva.Account.AccountLift)
@:forward abstract Account<T>(AccountDef<T>) from AccountDef<T> to AccountDef<T>{
  static public var _(default,never) = AccountLift;
  public inline function new(self:AccountDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:AccountDef<T>):Account<T> return new Account(self);
  @:noUsing static inline public function unit<T>(){
    return lift(Nil);
  }
  @:from static public function fromLinkedListSum<T>(self:LinkedListSum<Journal<T>>){
    return lift(self);
  }
  public function prj():AccountDef<T> return this;
  private var self(get,never):Account<T>;
  private function get_self():Account<T> return lift(this);
}
class AccountLift{

}