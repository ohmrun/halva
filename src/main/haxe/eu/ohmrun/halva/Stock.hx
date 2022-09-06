package eu.ohmrun.halva;

interface StockApi<K,V> extends AccretionApi<V>{
  public function bestow(k:K,v:V):Bool;
  public function obtain(k:K,threshold:ThresholdSet<V>):Future<Option<LVar<V>>>;
  public function exists(k:K):Bool;
}
class StockCls<K,V> extends AccretionCls<V> implements StockApi<K,V>{
  //final cache    : RedBlackSet.
  final internal : haxe.ds.Map<K,Register>;
  public function new(satisfies,data,internal:Map<K,Register>){
    super(satisfies,data);
    this.internal = internal;
  }
  override public function create():Register{
    final register = super.create();
    this.update(register,BOT);
    return register;
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
  public function obtain(k:K,threshold:ThresholdSet<V>):Future<Option<LVar<V>>>{
    final register = internal.get(k);
    return if(register == null){
      Future.irreversible((cb) -> cb(None));
    }else{
      this.redeem(register,threshold);
    }
  }
  public function exists(k:K):Bool{
    return this.internal.exists(k);
  }
}