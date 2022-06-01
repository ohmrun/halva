package stx.assert.halva.eq;

import eu.ohmrun.halva.Journal as TJournal;

class Journal<T> extends EqCls<TJournal<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TJournal<T>,rhs:TJournal<T>){
    return switch([lhs,rhs]){
      case [Record(knuckleI,accountI),Record(knuckleII,accountII)] : 
        var eq = new stx.assert.halva.eq.Knuckle().comply(knuckleI,knuckleII);
        if(eq.is_equal()){
          eq = new stx.assert.halva.eq.Junction(new stx.assert.halva.eq.Account(this)).comply(accountI,accountII);
        }    
        eq;
      case [Figure(figureI),Figure(figureII)] :
        new stx.assert.halva.eq.LVar(this.inner).comply(figureI,figureII);
      case [x,y]                                        : Eq.EnumValueIndex().comply(x,y);
    }
  }
}