package eu.ohmrun.halva;

interface StockApi<K,V> extends AccretionApi<V>{
  public function bestow(k:K,v:V):Bool;
  public function obtain(k:K,threshold:ThresholdSet<V>):Future<LVar<V>>;
}
class StockCls<K,V> extends AccretionCls<V> implements StockApi<K,V>{
  final internal : Map<K,Register>;
  public function new(satisfies,data,internal:Map<K,Register>){
    super(satisfies,data);
    this.internal = internal;
  }
  public function bestow(k:K,v:V):Bool{
    var register = internal.get(k);
    if(register == null){
      register = this.create();
    }
    return this.update(register,HAS(v,false)).if_else(
      () -> {
        this.internal.set(k,register);
        return true;
      },
      () -> {
        return false;
      }
    );
  }
  public function obtain(k:K,threshold:ThresholdSet<V>):Future<LVar<V>>{
    final register = internal.get(k);
    return if(register == null){
      Future.sync(BOT);
    }else{
      this.redeem(register,threshold);
    }
  }
}