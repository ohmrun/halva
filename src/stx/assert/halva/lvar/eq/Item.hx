package stx.assert.halva.lvar.eq;

import eu.ohmrun.halva.lvar.Item as TItem;

class Item<T> extends EqCls<TItem<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TItem<T>,rhs:TItem<T>){
    return switch([lhs,rhs]){
      case [LvBottom,LvBottom]    : AreEqual;
      case [LvNode(l),LvNode(r)]  : inner.comply(l,r);
      case [LvTop,LvTop]          : AreEqual;
      default                     : Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}