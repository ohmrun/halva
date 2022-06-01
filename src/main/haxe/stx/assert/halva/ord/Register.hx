package stx.assert.halva.ord;

import eu.ohmrun.halva.core.Register as TRegister;

class Register extends OrdCls<TRegister>{
  public function new(){}
  public function comply(lhs:TRegister,rhs:TRegister){
    return lhs.less_than(rhs);
  }
}
