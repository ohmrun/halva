package stx.assert.halva.ord;

import eu.ohmrun.halva.Account as TAccount;

class Account<T> extends OrdCls<TAccount<T>>{
  final inner : Ord<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TAccount<T>,rhs:TAccount<T>){
    return switch([lhs.prj(),rhs.prj()]){      
      case [Nil,Nil]                           : NotLessThan;
      case [Cons(vI,restI),Cons(vII,restII)]   : 
        final   l = lhs.toIter().toArray();
        final   r = rhs.toIter().toArray();
        var ord : Ordered = if(l.length < r.length){
          LessThan;
        }else{
          NotLessThan;
        }
        ord = new stx.assert.halva.ord.Journal(inner).comply(vI,vII);
        if(ord.is_not_less_than()){
          Ord.Array(new stx.assert.halva.ord.Journal(inner)).comply(l,r);
        }
        ord;
      case [x,y]                               : Ord.EnumValueIndex().comply(x,y);
    }
  }
}
