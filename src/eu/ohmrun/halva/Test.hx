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
    var set = RedBlackSet.make(__.Assert().Comparable().Item(Comparable.Cluster(Comparable.Int())));
        set = set.put(LvNode([0,1,2].imm()));
    var a : LVar<Cluster<StdInt>> = new eu.ohmrun.halva.lvar.term.Array(Comparable.Int());
        a = a.put([0,1,2].imm()).get_and_put(
          set,
          ok -> {
            return [3,4,5];
          }
        ).put([3,4,5,6].imm()).get_and_put(
          set.put(LvNode([3,4,5,6].imm())),
          ok -> {
            return __.tracer()(ok).last().fold(
              item -> item.fold(
                ()      -> None,
                arr     -> Some(arr.snoc(7)),
                ()      -> None
              ),
              ()   -> None
            );
          }
        );
        trace(__.show(a.get(set.put(LvNode([3,4,5,6].imm()))).last()));
  }
}