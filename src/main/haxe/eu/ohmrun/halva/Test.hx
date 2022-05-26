package eu.ohmrun.halva;

using stx.Show;
using stx.Test;

class Test{
  static public function main(){
    __.test(
      [
        new HalvaTest()
      ],[]
    );
  }
}
class HalvaTest extends TestCase{
  public function test(){
    final a = Extra
      (
        Record(
          Nominal("a"),
          Extra(
            Record(
              Nominal("a.b"),Extra(Figure(1),Bound)
            ),
            Extra(
              Record(
                Nominal("a.c"),
                Extra(Figure(2),Bound)
              ),
              Bound
            )
        )
      ),Spare
    );
    // final f = (x){
    //   return switch(x){
    //     case Record(knuckle) : 
    //   }
    // }
    trace(__.show(a));
  }
}
interface HalvishApi<T> extends SemiGroupApi<Halvesque<T>> extends ComparableApi<Halvesque<T>>{
  
}
typedef HalvishValueDef<T>  = { data : RedBlackSet<Halvesque<T>>, with : SemiGroup<Halvesque<T>> };
typedef Halvesque<T>        = Account<Journal<T>>;

abstract HalvishValue<T>(HalvishValueDef<T>) from HalvishValueDef<T> to HalvishValueDef<T>{
  public function new(self) this = self;
  @:noUsing static public function lift<T>(self:HalvishValueDef<T>):HalvishValue<T> return new HalvishValue(self);
  @:noUsing static public function make<T>(with:SemiGroup<Halvesque<T>>,?data:RedBlackSet<Halvesque<T>>){
    return lift({
      with : with,
      data : data
    });
  }
  @:noUsing static public function make0<T>(with:HalvishApi<T>,?data:RedBlackTree<Halvesque<T>>){
     return make(
      with.toSemiGroup(),
      RedBlackSet.make(with.toComparable(),data)
    );
  }
  public function copy(?data:RedBlackSet<Halvesque<T>>){
    return make(this.with,__.option(data).defv(this.data));
  }
  public function prj():HalvishValueDef<T> return this;
  private var self(get,never):HalvishValue<T>;
  private function get_self():HalvishValue<T> return lift(this);
}

// interface HalvishStoreApi<T>{
//   public function create():Register;
//   public function update(r:Register,?state:Halvesque<T>):Report<HalvaFailure>;
//   public function redeem(r:Register,threshold:RedBlackSet<Halvesque<T>>):Future<Halvesque<T>>;
//   public function freeze(r:Register):Void;
   
//   public function toStore():HalvishStore<T>;
// }
enum Threshold<T>{
  Th(set:RedBlackSet<Halvesque<T>>);
  ThGraph;
  ThValue;
}