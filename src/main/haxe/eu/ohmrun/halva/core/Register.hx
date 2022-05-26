package eu.ohmrun.halva.core;

abstract Register(Int){
  public function new(){
    this = @:privateAccess RegisterLift.counter.next();
  }
}
private class RegisterLift{
  static private var counter(get,null) : Counter;
  static public function get_counter(){
    return counter == null ? new Counter() : counter;
  }
}