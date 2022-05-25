package eu.ohmrun.halva.core;

interface StoreApi<T>{
  public function create():Register;
  public function update(r:Register,?state:Memo<Item<T>>):Void;
  public function redeem(r:Register,threshold:ThresholdSet<T>):Future<Memo<Item<T>>>;
  //public function embody(r:Register,threshold:ThresholdSet<T>):Bool;
  
   
  public function toStore():Store<T>;
}
abstract class StoreCls<T> implements StoreApi<T>{
  public function toStore():Store<T>{
    return this;
  }
}
class FirstStore<T> extends StoreCls<T>{
  final values : Map<Register,ThresholdSet<T>>;
  public function new(values){
    this.values = values;
  }
}
@:using(eu.ohmrun.halva.core.Store.StoreLift)
@:forward abstract Store<T>(StoreApi<T>) from StoreApi<T> to StoreApi<T>{
  static public var _(default,never) = StoreLift;
  public inline function new(self:StoreApi<T>) this = self;
  @:noUsing static inline public function lift<T>(self:StoreApi<T>):Store<T> return new Store(self);

  public function prj():StoreApi<T> return this;
  private var self(get,never):Store<T>;
  private function get_self():Store<T> return lift(this);
}
class StoreLift{
  static public inline function lift<T>(self:StoreApi<T>):Store<T>{
    return Store.lift(self);
  }
}