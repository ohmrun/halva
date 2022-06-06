package eu.ohmrun.halva.ds;

class Map<K,V>{
  final accretion             : Accretion<RedBlackMap<K,V>>;
  final id                    : Register;
  final unit                  : RedBlackMap<K,V>;
  //whatever rules you make about Ord Eq here plays in the SemiGroup<LVar<T>>;
  public final threshold      : ThresholdSet<RedBlackMap<K,V>>;
  
  public function new(accretion,unit,threshold){
    this.accretion      = accretion; 
    this.id             = accretion.create(); 
    this.unit           = unit;
    this.threshold      = threshold;
  }
  static public function make(accretion,unit,threshold){
    return new Map(accretion,unit,threshold);
  }
  public function set(key:K,val:V):Alert<HalvaFailure>{
    return this.accretion.redeem(id,this.threshold).map(
      (lvar) -> {
        this.accretion.update(
          this.id,
          switch(lvar){
            case BOT  : HAS(unit.set(key,val),false);
            default   : lvar.map(x -> x.set(key,val)); 
          }
        );
        return __.report();
      }
    );
  }
  public function get(key:K,?threshold:ThresholdSet<RedBlackMap<K,V>>):Future<Option<V>>{
    return accretion.redeem(id,__.option(threshold).defv(this.threshold)).map(
      (lvar) -> lvar.fold(
        ()    -> None,
        (x,_) -> x.get(key),
        ()    -> None
      )
    );
  }
} 
private class MapLub<K,V> extends SemiGroupCls<LVar<RedBlackMap<K,V>>>{
  final map     : Comparable<LVar<RedBlackMap<K,V>>>;
  final value   : Comparable<V>;
  public function new(map,value){
    super();
    this.map    = map;
    this.value  = value;
  }
  public function plus(lhs:LVar<RedBlackMap<K,V>>,rhs:LVar<RedBlackMap<K,V>>){
    return lhs.zip(rhs).flat_map(
      __.decouple(
        (a:RedBlackMap<K,V>,b:RedBlackMap<K,V>) -> {
          final free      = a.unit();
          final both      = a.union(b);
          var fail        = false;
          final do_fail   = () -> fail = true;

          for(tp in both){
            var k = tp.key;
            var v = tp.val;

            final l = a.get(k);
            final r = b.get(k);
            switch([l,r]){
              case [Some(lI),Some(rI)] : 
                if(value.lt().comply(lI,rI).is_less_than()){
                  do_fail();
                }  
              case [Some(_),None] : 
                do_fail();          
              default : 
            } 
            if(fail){
              break;
            }
          }
          if(fail){
            TOP;
          }else{
            HAS(both,rhs.frozen);
          }
        }
      )
    );
  }
}