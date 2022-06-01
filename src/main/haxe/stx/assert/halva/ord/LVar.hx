package stx.assert.halva.ord;

import eu.ohmrun.halva.LVar as TLVar;

class LVar<T> extends OrdCls<TLVar<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TLVar<T>,rhs:TLVar<T>){
    return switch([lhs,rhs]){
      case [BOT,BOT]                            : NotLessThan;
      case [HAS(vI),HAS(vII)]                   : inner.comply(vI,vII);
      case [TOP,TOP]                            : NotLessThan;
      case [x,y]                                : Ord.EnumValueIndex().comply(x,y);
    }
  }
}
