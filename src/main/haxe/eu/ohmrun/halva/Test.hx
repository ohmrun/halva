package eu.ohmrun.halva;

using stx.Show;
using stx.Test;

class Test{
  static public function tests(){
    return [
      new HalvaTest(),
    ];
  }
  static public function main(){
    __.test().run(
      [
        new HalvaTest()
      ],[]
    );
  }
}
class HalvaTest extends TestCase{
  public function test(){
    final map     = eu.ohmrun.halva.ds.map.term.StringMap.make(Comparable.Int());
    try{
      map.set("hello",2)
         .zip(map.set("hello",1))
         .zip(map.set("third",99))
         .handle(
          report -> {
              trace(report);
              map.get("third").handle(
                (x) -> {
                  trace(x);
                  map.get("hello").handle(
                    (x) -> trace(x)
                  );
                } 
              );
          }
         );
    }catch(e:Dynamic){
      trace(e);
    }
  }
}