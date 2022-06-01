package eu.ohmrun.halva.account;

class Monoid<T> implements SemiGroupApi<Account<T>>{
  final with : Comparable<T>;
  public function new(with){
    this.with = with;
  }
  public function plus(lhs:Account<T>,rhs:Account<T>):Account<T>{
    return switch([lhs.prj(),rhs.prj()]){
      case [Nil,Nil]                    : rhs;
      case [l,r]                        : 
        final larr : Cluster<Journal<T>> = l.toIter().toCluster();
        final rarr : Cluster<Journal<T>> = r.toIter().toCluster();
        if(rarr.length > larr.length){
          rhs;
        }else if(rarr.length < larr.length){
          lhs;
        }else{
          switch(Ord.Cluster(new stx.assert.halva.ord.Journal(with.lt())).comply(larr,rarr)){
            case LessThan     : lhs;
            case NotLessThan  : rhs;
          }
        }
    }
  }
  public function toSemiGroup(){
    return SemiGroup.lift(this);
  }
}