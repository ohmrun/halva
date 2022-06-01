package stx.assert.halva.ord;

import eu.ohmrun.halva.Journal as TJournal;

class Journal<T> extends OrdCls<TJournal<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TJournal<T>,rhs:TJournal<T>){
    return switch([lhs,rhs]){
      case [Record(knuckleI,accountI),Record(knuckleII,accountII)] : 
        var ord = new stx.assert.halva.ord.Knuckle().comply(knuckleI,knuckleII);
        if(ord.is_not_less_than()){
          ord = new stx.assert.halva.ord.Junction(new stx.assert.halva.ord.Account(this)).comply(accountI,accountII);
        }    
        ord;
      case [Figure(figureI),Figure(figureII)] :
        new stx.assert.halva.ord.LVar(this.inner).comply(figureI,figureII);
      case [x,y]                                        : Ord.EnumValueIndex().comply(x,y);
    }
  }
}