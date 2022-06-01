package eu.ohmrun.halva;

interface AccretionApi<T>{
  private final with    : Monoid<Account<T>>;
  private var   data    : RedBlackMap<Register,Account<T>>;
  private final _signal : SignalTrigger<Couple<Register,Account<T>>>;
  private final signal  : Signal<Couple<Register,Account<T>>>;

  public function toAccretion():Accretion<T>;
}
class AccretionCls<T> implements AccretionApi<T>{
  final with              : Monoid<Account<T>>;
  var data                : RedBlackMap<Register,Account<T>>;
  private final _signal   : SignalTrigger<Couple<Register,Account<T>>>;
  private final signal    : Signal<Couple<Register,Account<T>>>;

  public function new(with,data){
    this.with       = with;
    this.data       = data;
    this._signal    = Signal.trigger();
    this.signal     = _signal.asSignal();
  }
  public function toAccretion(){
    return Accretion.lift(this);
  }
  public function create():Register{
    final reg = new Register();
    this.data = this.data.set(reg,Account.unit());
    return reg;
  }
  public function update(r:Register,data:Account<T>):Void{
    final next  = this.with.plus(this.data.get(r).defv(Account.unit()),data);
    this.data   = this.data.set(r,next);
    _signal.trigger(__.couple(r,next));
  }
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<Account<T>>{
    final next = this.data.get(r).defv(Account.unit());
    return filter(next,threshold).if_else(
      () -> Future.irreversible(cb -> cb(next)),
      () -> listen(r,threshold).nextTime(_ -> true)
    );
  }
  public function listen(r:Register,threshold:ThresholdSet<T>):Signal<Account<T>>{
    return signal.filter(
      __.decouple(
        (x,y) -> (x == r) && filter(y,threshold)
      )
    ).map(__.decouple((_,y) -> y));
  }
  static private function filter<T>(item:Account<T>,threshold:ThresholdSet<T>){
    return threshold.toIter().lfold(
      (next:Account<T>,m:Bool) -> m.if_else(
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
  @:noUsing static public function unit<T>(){
    return Ref.to(RedBlackMap.make(Comparable.Anon(Eq.Anon(Register._.equals),Ord.Anon(Register._.less_than))));
  }
  public function prj():AccretionApi<T> return this;
  private var self(get,never):Accretion<T>;
  private function get_self():Accretion<T> return lift(this);
}
class AccretionLift{
  static public inline function lift<T>(self:AccretionApi<T>):Accretion<T>{
    return Accretion.lift(self);
  }
} 