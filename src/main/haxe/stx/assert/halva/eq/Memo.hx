package stx.assert.halva.eq;

import eu.ohmrun.halva.core.Memo as TMemo;

class Memo<T> extends EqCls<TMemo<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TMemo<T>,rhs:TMemo<T>){
    return switch([lhs.frozen,rhs.frozen]){
      case [true,true] | [false,false]          : 
        inner.comply(lhs.value,rhs.value);
      default                                   : AreNotEqual;
    }
  }
}
