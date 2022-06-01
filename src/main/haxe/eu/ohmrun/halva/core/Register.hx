package eu.ohmrun.halva.core;

@:using(eu.ohmrun.halva.core.Register.RegisterLift)
@:allow(eu.ohmrun) abstract Register(Int){
  static public var _(default,never) = RegisterLift;
  public function new(){
    this = @:privateAccess RegisterLift.counter.next();
  }
  private function prj():Int{
    return this;
  }
}
private class RegisterLift{
  static private var counter(get,null) : Counter;
  static public function get_counter(){
    return counter == null ? new Counter() : counter;
  }
  static public function less_than(thiz:Register,that:Register){
    return thiz.prj() < that.prj() ? LessThan : NotLessThan;
  }
  static public function equals(thiz:Register,that:Register){
    return thiz.prj() == that.prj() ? AreEqual : NotEqual;
  }
}