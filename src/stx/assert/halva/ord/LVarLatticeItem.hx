package eu.ohmrun.stx.assert.halva.ord;

import LVarLatticeItem in TLVarLatticeItem;

class LVarLatticeItem<T> extends stx.assert.Ord.OrdCls<TLVarLatticeItem<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TLVarLatticeItem<T>,rhs:TLVarLatticeItem<T>){
    return switch([lhs,rhs]){
      case [TOP,TOP]            : NotLessThan;
      case [NODE(vI),NODE(vII)] : inner.comply(vI,vII);
      case [BOTTOM,BOTTOM]      : NotLessThan;
      default                   : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}