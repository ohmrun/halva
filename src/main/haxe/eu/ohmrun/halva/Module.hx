package eu.ohmrun.halva;

class Module extends Clazz{
  public function account<T>():eu.ohmrun.halva.Account.AccountCtr<T>{
    return new eu.ohmrun.halva.Account.AccountCtr();
  }
  //public function record<T>(knuckle:Knuckle,account:AccountCtr<T> -> Account<T>)
}