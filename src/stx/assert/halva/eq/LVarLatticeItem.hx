package eu.ohmrun.stx.assert.halva.eq;

import LVarLatticeItem in TLVarLatticeItem;

class LVarLatticeItem<T> extends stx.assert.Eq.EqCls<TLVarLatticeItem<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TLVarLatticeItem<T>,rhs:TLVarLatticeItem<T>){
    return switch([lhs,rhs]){
      case [TOP,TOP]            : AreEqual;
      case [NODE(vI),NODE(vII)] : inner.comply(vI,vII);
      case [BOTTOM,BOTTOM]      : AreEqual;
      default                   : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}