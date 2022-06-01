package stx.assert.halva.eq;

import eu.ohmrun.halva.core.Register as TRegister;

class Register extends EqCls<TRegister>{
  public function new(){}
  public function comply(lhs:TRegister,rhs:TRegister){
    return lhs.equals(rhs);
  }
}
