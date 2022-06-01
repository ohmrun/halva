package stx.assert.halva.comparable;

import eu.ohmrun.halva.Journal in TJournal;

class Journal<T> extends ComparableCls<TJournal<T>>{
  final inner : Comparable<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function lt(){
    //return new stx.assert.halva.ord.Journal(inner.lt());
    return throw UNIMPLEMENTED;
  }
  public function eq(){
    return new stx.assert.halva.eq.Journal(inner.eq());
  }
}