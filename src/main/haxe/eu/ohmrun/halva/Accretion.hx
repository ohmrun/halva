package eu.ohmrun.halva;

interface AccretionApi<T>{
  public final lub         : SemiGroup<LVar<T>>;
  public final comparable  : Comparable<LVar<T>>;

  private var   data        : RedBlackMap<Register,LVar<T>>;

  private final _signal : SignalTrigger<Couple<Register,LVar<T>>>;
  private final signal  : Signal<Couple<Register,LVar<T>>>;

  public function create():Register;
  public function update(r:Register,data:LVar<T>):Void;
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<LVar<T>>;
  public function listen(r:Register,threshold:ThresholdSet<T>):Signal<LVar<T>>;
  
  public function toAccretion():Accretion<T>;
}
class AccretionCls<T> implements AccretionApi<T>{

  public final lub                : SemiGroup<LVar<T>>;
  public final comparable         : Comparable<LVar<T>>;

  var data                : RedBlackMap<Register,LVar<T>>;

  private final _signal   : SignalTrigger<Couple<Register,LVar<T>>>;
  private final signal    : Signal<Couple<Register,LVar<T>>>;

  public function new(lub,comparable,data){
    this.lub              = lub;
    this.comparable       = comparable;
    this.data             = data;
    this._signal          = Signal.trigger();
    this.signal           = _signal.asSignal();
  }
  public function toAccretion(){
    return Accretion.lift(this);
  }
  public function create():Register{
    final reg = new Register();
    this.data = this.data.set(reg,LVar.unit());
    return reg;
  }
  public function update(r:Register,data:LVar<T>):Void{
    final last  = this.data.get(r).defv(LVar.unit());
    final next  = this.lub.plus(last,data);
    if(next != TOP){
      if(this.comparable.eq().comply(last,next).is_equal() || this.comparable.lt().comply(last,next).is_less_than()){
        this.data   = this.data.set(r,next);
        _signal.trigger(__.couple(r,next));
      }
    }
  }
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<LVar<T>>{
    final next = this.data.get(r).defv(LVar.unit());
    return filter(next,threshold).if_else(
      () -> Future.irreversible(cb -> cb(next)),
      () -> listen(r,threshold).nextTime(_ -> true)
    );
  }
  public function listen(r:Register,threshold:ThresholdSet<T>):Signal<LVar<T>>{
    return signal.filter(
      __.decouple(
        (x,y) -> (x == r) && filter(y,threshold)
      )
    ).map(__.decouple((_,y) -> y));
  }
  static private function filter<T>(item:LVar<T>,threshold:ThresholdSet<T>){
    return threshold.toIter().lfold(
      (next:LVar<T>,m:Bool) -> m.if_else(
        () -> threshold.with.lt().comply(item,next).is_not_less_than() || threshold.with.eq().comply(item,next).is_equal(),
        () -> false
      ),
      true
    );
  }
}
@:using(eu.ohmrun.halva.Accretion.AccretionLift)
@:forward abstract Accretion<T>(AccretionApi<T>) from AccretionApi<T> to AccretionApi<T>{
  static public var _(default,never) = AccretionLift;
  public inline function new(self:AccretionApi<T>) this = self;
  @:noUsing static inline public function lift<T>(self:AccretionApi<T>):Accretion<T> return new Accretion(self);
  
  @:noUsing static public function make<T>(lub:SemiGroup<LVar<T>>,comparable,data:RedBlackMap<Register,LVar<T>>){
    return lift(new AccretionCls(lub,comparable,data));
  }
  public function prj():AccretionApi<T> return this;
  private var self(get,never):Accretion<T>;
  private function get_self():Accretion<T> return lift(this);
}
class AccretionLift{
  static public inline function lift<T>(self:AccretionApi<T>):Accretion<T>{
    return Accretion.lift(self);
  }
  // static public function latest<T>(self:AccretionApi<T>):Future<T>{

  // }
} 