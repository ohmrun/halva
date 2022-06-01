package eu.ohmrun.halva;

typedef StorageDef<T> = Res<Accretion<T>,HalvaFailure>;

@:using(eu.ohmrun.halva.Storage.StorageLift)
abstract Storage<T>(StorageDef<T>) from StorageDef<T> to StorageDef<T>{
  static public var _(default,never) = StorageLift;
  public inline function new(self:StorageDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:StorageDef<T>):Storage<T> return new Storage(self);

  public function prj():StorageDef<T> return this;
  private var self(get,never):Storage<T>;
  private function get_self():Storage<T> return lift(this);
}
class StorageLift{
  static public inline function lift<T>(self:StorageDef<T>):Storage<T>{
    return Storage.lift(self);
  }
}