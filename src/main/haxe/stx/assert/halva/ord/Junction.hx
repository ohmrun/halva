package stx.assert.halva.ord;

import eu.ohmrun.halva.Junction as TJunction;

class Junction<T> extends OrdCls<TJunction<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TJunction<T>,rhs:TJunction<T>){
    return switch([lhs,rhs]){
      case [There(vI),There(vII)]                       : new stx.assert.halva.ord.Register().comply(vI,vII);
      case [Whole(vI),Whole(vII)]                       : inner.comply(vI,vII);
      case [x,y]                                        : Ord.EnumValueIndex().comply(x,y);
    }
  }
}