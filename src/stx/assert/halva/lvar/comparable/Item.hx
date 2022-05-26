package stx.assert.halva.lvar.comparable;

import eu.ohmrun.halva.lvar.Item as TItem;

class Item<T> extends ComparableCls<TItem<T>>{
  final inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function eq(){
    return new stx.assert.halva.lvar.eq.Item(inner.eq());
  }
  public function lt(){
    return new stx.assert.halva.lvar.ord.Item(inner.lt());
  }
}