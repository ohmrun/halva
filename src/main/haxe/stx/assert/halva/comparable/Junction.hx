package stx.assert.halva.comparable;

import eu.ohmrun.halva.Junction in TJunction;

class Junction<T> extends ComparableCls<TJunction<T>>{
  final inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function lt(){
    return new stx.assert.halva.ord.Junction(inner.lt());
  }
  public function eq(){
    return new stx.assert.halva.eq.Junction(inner.eq());
  }
}