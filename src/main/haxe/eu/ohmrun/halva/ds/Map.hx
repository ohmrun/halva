package eu.ohmrun.halva.ds;

class Map<K,V>{
  final accretion             : Accretion<RedBlackMap<K,V>>;
  final id                    : Register;
  final unit                  : RedBlackMap<K,V>;
  //whatever rules you make about Ord Eq here plays in lub, which is only put if the result >= previous and not TOP 
  //public final threshold      : ThresholdSet<RedBlackMap<K,V>>;
  
  public function new(accretion,unit){
    this.accretion      = accretion; 
    this.id             = accretion.create(); 
    this.unit           = unit;
  }
  static public function make(accretion,unit){
    return new Map(accretion,unit);
  }
  public function set(key:K,val:V):Alert<HalvaFailure>{
    final default_threshold = RedBlackSet.make(accretion.satisfies.toComparable());
    return this.accretion.redeem(id,default_threshold).map(
      (lvar) -> {
        trace('redeemed $lvar on $key before set');
        final changed = this.accretion.update(
          this.id,
          switch(lvar){
            case BOT  : HAS(unit.set(key,val),false);
            default   : lvar.map(x -> x.set(key,val)); 
          }
        );
        trace(changed);
        return __.report();
      }
    );
  }
  public function get(key:K,?threshold:ThresholdSet<RedBlackMap<K,V>>):Future<Option<V>>{
    final default_threshold = RedBlackSet.make(accretion.satisfies.toComparable());
    return accretion.redeem(id,__.option(threshold).defv(default_threshold)).map(
      (lvar) -> lvar.fold(
        ()    -> None,
        (x,_) -> x.get(key),
        ()    -> None
      )
    );
  }
}
