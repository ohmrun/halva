package eu.ohmrun.halva.lvar.term;

typedef ArrayDef<T> = LVar<Cluster<T>>;

@:using(stx.coroutine.core.Coroutine.CoroutineLift)
@:using(eu.ohmrun.halva.lvar.term.Array.ArrayLift)
@:forward abstract Array<T>(LVar<Cluster<T>>) from ArrayDef<T> to ArrayDef<T>{
  public function new(comparable:Comparable<T>){
    final c : Comparable<Item<Cluster<T>>>  = new stx.assert.halva.lvar.comparable.Item(Comparable.Cluster(comparable));
    var set                                 = RedBlackSet.make(c);
    
    this = LVar.lift(__.tran(
      function rec(op:LVarOp<Cluster<T>>){
        trace(__.show(op));
        return switch(op){
          case Put(put) :  
            set = set.put(LvNode(put));
            trace(__.show(set));
            __.tran(rec);
          case Get(activation_set) : 
              final this_last = set.last();
              final mask_last = activation_set.last();
              trace('this_last: $this_last mask_last: $mask_last');
              switch([this_last,mask_last]){
                case [Some(this_last),Some(mask_last)] :  
                  if(c.lt().comply(mask_last,this_last).is_ok() || c.eq().comply(this_last,mask_last).is_ok()){
                    //set = set.union(activation_set);
                    trace('emit');
                    __.emit(set,__.tran(rec));
                  }else{
                    trace('no emit');
                    __.tran(rec);
                  }
                case [Some(this_last),None] : 
                  __.emit(set,__.tran(rec));
                default : 
                  __.tran(rec);
              }
          case Freeze : 
              __.prod(set);
        }
      }
    ));
  } 
  @:to public function toCoroutine(){
    return Coroutine.lift(this);
  }
}
class ArrayLift{
  static public function snoc<T>(self:Array<T>,activation_set:ActivationSet<StdArray<T>>,i:T){
    return self.get_and_put(
      activation_set,
      (set) -> set.last().flat_map(
        ok -> ok.option().map(
          arr -> arr.snoc(i)
        )
      )
    );
  }
  static public function set<T>(self:Array<T>,activation_set:ActivationSet<StdArray<T>>,index:Int,i:T){
    return self.get_and_put(
      activation_set,
      (set) -> set.last().flat_map(
        ok -> ok.option().map(
          arr -> arr.set(index,i)
        )
      )
    );
  }
}