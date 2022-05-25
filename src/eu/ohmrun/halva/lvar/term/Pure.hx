package eu.ohmrun.halva.lvar.term;

@:using(stx.coroutine.core.Coroutine.CoroutineLift)
abstract Pure<T>(LVarDef<T>) from LVarDef<T> to LVarDef<T>{
  public function new(comparable:Comparable<T>){
    final listeners  = [];
    final c : Comparable<Item<T>>       = new stx.assert.halva.lvar.comparable.Item(comparable);
    var set                             = RedBlackSet.make(c).put(LvBottom);
    
    this = LVar.lift(__.tran(
      function rec(op:LVarOp<T>){
        trace(op);
        return switch(op){
          case Listen(listener) : 
            listeners.push(listener);
          case Put(put) :  
            set = set.put(LvNode(put));
            __.log().trace(_ -> _.thunk(() -> '$set'));
            __.tran(rec);
          case Get(activation_set) : 
              final this_last = set.last();
              final mask_last = activation_set.last();
              trace('this_last: $this_last mask_last: $mask_last');
              switch([this_last,mask_last]){
                case [Some(this_last),Some(mask_last)] :  
                  if(c.lt().comply(mask_last,this_last).is_ok() || c.eq().comply(this_last,mask_last).is_ok()){
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
  public function prj():LVarDef<T>{
    return this;
  }
}