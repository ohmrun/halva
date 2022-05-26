package eu.ohmrun.halva.lvar.term;

@:using(stx.coroutine.core.Coroutine.CoroutineLift)
abstract Int(LVar<StdInt>) from LVar<StdInt> to LVar<StdInt>{
  public function new(){
    final c : Comparable<Item<StdInt>>  = new stx.assert.halva.lvar.comparable.Item(Comparable.Int());
    var set                             = RedBlackSet.make(c).put(LvBottom);
    
    this = LVar.lift(__.tran(
      function rec(op:LVarOp<StdInt>){
        trace(op);
        return switch(op){
          case Put(put) :  
            set = set.put(LvNode(put));
            trace(set);
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