package stx.assert.halva.core.ord;

import eu.ohmrun.halva.core.Memo in TMemo;

class Memo<T> extends OrdCls<TMemo<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TMemo<T>,rhs:TMemo<T>){
    var ord = Ord.Bool().comply(lhs.frozen,rhs.frozen);
    if(ord.is_not_less_than()){
      ord = inner.comply(lhs.value,rhs.value);
    }
    return ord;
  }
}
