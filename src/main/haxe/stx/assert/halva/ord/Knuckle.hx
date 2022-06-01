package stx.assert.halva.ord;

import eu.ohmrun.halva.Knuckle as TKnuckle;

class Knuckle extends OrdCls<TKnuckle>{
  public function new(){}
  public function comply(lhs:TKnuckle,rhs:TKnuckle){
    return switch([lhs,rhs]){
      case [Ordinal(vI),Ordinal(vII)]          : vI < vII ? LessThan : NotLessThan;
      case [Nominal(vI),Nominal(vII)]          : Ord.String().comply(vI,vII);
      case [x,y]                               : Ord.EnumValueIndex().comply(x,y);
    }
  }
}
