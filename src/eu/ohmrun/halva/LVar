package eu.ohmrun.halva;

typedef LVarDef<T> = CoroutineSum<LVarOp<T>,ActivationSet<T>,ActivationSet<T>,HalvaFailure>;

@:using(stx.coroutine.core.Coroutine.CoroutineLift)
@:using(eu.ohmrun.halva.LVar.LVarLift)
@:transitive abstract LVar<T>(LVarDef<T>) from LVarDef<T> to LVarDef<T>{
  static public var _(default,never) = LVarLift;
  public inline function new(self:LVarDef<T>) this = self;
  @:noUsing static inline public function lift<T>(self:LVarDef<T>):LVar<T> return new LVar(self);

  public function prj():LVarDef<T> return this;
  private var self(get,never):LVar<T>;
  private function get_self():LVar<T> return lift(this);

  @:to public function toCoroutine(){
    return Coroutine.lift(this);
  }
}
class LVarLift{
  static public inline function lift<T>(self:LVarDef<T>):LVar<T>{
    return LVar.lift(self);
  }
  static public function put<T>(self:LVarDef<T>,v:T):LVar<T>{
    return self.provide(Put(v));
  }
  static public function get<T>(self:LVarDef<T>,set:ActivationSet<T>):LVar<T>{
    return self.provide(Get(set));
  }
  static public function get_and_put<T>(self:LVarDef<T>,set:ActivationSet<T>,fn : ActivationSet<T> -> Option<T>):LVar<T>{
    final f     = get_and_put.bind(_,set,fn);
    final last = last(get(self,set));
    trace(__.show(last));
    return switch(last){
      case Halt(Production(_)) : __.halt(__.fault().of(E_Halva_Frozen));
      case Halt(Terminated(t)) : __.term(t);
      case Hold(held)          : __.hold(held.mod(f));
      case Wait(fn)            : __.wait(fn.mod(f));
      case Emit(head,rest)     : 
        __.log().trace(_ -> _.thunk(() -> __.show(rest)));
        __.emit(head,
          fn(head).fold(
            ok -> {
              __.log().trace(_ -> _.thunk(() -> '$ok'));
              final aI = put(last,ok);
              __.log().trace(_ -> _.thunk(() -> __.show(aI)));
              __.log().trace(__.show(rest));
              return aI.append(() -> rest);
            },
            () -> rest
          )
        );
    }
  }
  static public function freeze<T>(self:LVarDef<T>){
    return self.provide(Freeze);
  }
  /**
    Produces last available emit in the frame, or the frozen result if exists.
  **/
  static public function last<I,O,R,E>(self:CoroutineSum<I,O,R,E>){
    function f(self:CoroutineSum<I,O,R,E>,memo:Option<O>){
      return switch(self){
        case Emit(head,Wait(fn))        : self;
        case Emit(_,Halt(halt))         : __.halt(halt);
        case Emit(head,Hold(held))      : __.hold(
          held.mod(
            function rec(r){
              return switch(last(r)){
                case Halt(Terminated(x)) : __.term(x);
                case Halt(Production(c)) : __.prod(c);
                case Hold(h)             : __.hold(h.mod(rec));
                case Wait(w)             : __.emit(head,__.wait(w));
                case Emit(head,next)     : f(next,Some(head));
              }
            }
          )
        );
        case Emit(_,Emit(head,tail))   : f(tail,Some(head));
        case Wait(_)                   : memo.fold(
          ok -> __.emit(ok,self),
          () -> __.term(__.fault().explain(_ -> _.e_coroutine(E_Coroutine_Note_UnexpectedWait)))
        );
        case Hold(held)                : __.hold(held.mod(last));
        case Halt(e)                   : self;
      }
    }
    return f(self,None);
  }
}