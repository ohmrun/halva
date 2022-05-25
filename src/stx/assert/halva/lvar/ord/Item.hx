package stx.assert.halva.lvar.ord;

import eu.ohmrun.halva.lvar.Item as TItem;

class Item<T> extends OrdCls<TItem<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TItem<T>,rhs:TItem<T>){
    return switch([lhs,rhs]){
      case [LvBottom,LvBottom]    : NotLessThan;
      case [LvNode(l),LvNode(r)]  : inner.comply(l,r);
      case [LvTop,LvTop]          : NotLessThan;
      default                     : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}