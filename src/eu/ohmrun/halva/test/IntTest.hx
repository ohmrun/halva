package eu.ohmrun.halva.test;

class HalvaTest extends TestCase{
  @stx.test.Async
  public function test(async:Async){
    final state : LVar<Int>;

    final f = (x,?pos:haxe.PosInfos) -> {
      haxe.Log.trace(__.show(x),pos);
      return switch(x){
        default : null;
      }
    }
    var set  = RedBlackSet.make(
      __.Assert().Comparable().Item(Comparable.Int())
    ); 
    var lvar : LVar<Int> = new eu.ohmrun.halva.lvar.term.Int();
        lvar = lvar.put(1).get(set);
    trace(__.show(lvar));
    trace("__________________________");
    f(lvar);
    var setI    = set.put(LvNode(1));
        lvar    = lvar.get(setI);
    f(lvar);
    trace("__________________________");
    var setII   = setI.put(LvNode(2));
         lvar   = lvar.get(setII);
    f(lvar);
    trace("__________________________");
         lvar  = lvar.put(2);
         lvar  = lvar.get(setII);
    f(lvar);
    f(lvar.last());
    async.done();
  }
}