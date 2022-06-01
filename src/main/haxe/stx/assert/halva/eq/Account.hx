package stx.assert.halva.eq;

import eu.ohmrun.halva.Account as TAccount;

class Account<T> extends EqCls<TAccount<T>>{
  final inner : Eq<T>;
  public function new(inner){
    this.inner = inner;
  }
  public function comply(lhs:TAccount<T>,rhs:TAccount<T>){
    return switch([lhs.prj(),rhs.prj()]){
      case [Nil,Nil]                           : AreEqual;
      case [Cons(vI,restI),Cons(vII,restII)]   : 
        final   l = lhs.toIter().toArray();
        final   r = rhs.toIter().toArray();
        var eq : Equaled = if(l.length == r.length){
          AreEqual;
        }else{
          NotEqual;
        }
        eq = new stx.assert.halva.eq.Journal(inner).comply(vI,vII);
        if(eq.is_equal()){
          eq = Eq.Cluster(new stx.assert.halva.eq.Journal(inner)).comply(l,r);
        }
        eq;
      case [x,y]                               : Eq.EnumValueIndex().comply(x,y);
    }
  }
}
