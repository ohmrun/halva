package eu.ohmrun.halva;

abstract Register(Int){
  public function new(){
    this = RegisterLift.counter.next();
  }
}
private class RegisterLift{
  static private var counter(get,null) : Counter;
  public function get_counter(){
    return counter == null ? new Counter() : this.counter;
  }
}