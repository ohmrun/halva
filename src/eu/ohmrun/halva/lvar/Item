package eu.ohmrun.halva.lvar;

enum ItemSum<T>{
  LvBottom;
  LvNode(v:T);
  LvTop;
}
@:using(eu.ohmrun.halva.lvar.Item.ItemLift)
@:transitive abstract Item<T>(ItemSum<T>) from ItemSum<T> to ItemSum<T>{
  public function new(self) this = self;
  @:noUsing static public function lift<T>(self:ItemSum<T>):Item<T> return new Item(self);

  public function prj():ItemSum<T> return this;
  private var self(get,never):Item<T>;
  private function get_self():Item<T> return lift(this);
}
class ItemLift{
  static public function map<Ti,Tii>(self:Item<Ti>,fn:Ti->Tii):Item<Tii>{
    return fold(
      self,
      () -> LvBottom,
      ok -> LvNode(fn(ok)),
      () -> LvTop
    );
  }
  static public function fold<Ti,Z>(self:Item<Ti>,bottom: Void->Z,node:Ti->Z,top: Void->Z):Z{
    return switch(self){
      case LvBottom     : bottom();
      case LvNode(v)    : node(v);
      case LvTop        : top();
    }
  }
  static public function def<T>(self:Item<T>,fn:Void->T):T{
    return fold(
      self,
      fn,
      x -> x,
      fn
    );
  }
  static public function option<T>(self:Item<T>):Option<T>{
    return fold(self,() -> None,Some,() -> None);
  }
}