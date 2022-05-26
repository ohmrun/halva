package eu.ohmrun.halva;

enum EvaluationStateSum{
	EvalEmpty;
  EvalExpr(e:Expr);
  EvalThen(eI:EvaluationState,eII:EvaluationState);
  EvalGet(eI:EvaluationState,eII:EvaluationState);
  EvalPut(kind:Kind,e:EvaluationState);
  EvalFreeze(e:EvaluationState,?after_with:{ after : EvaluationState, with : EvaluationState});   
}

@:using(eu.ohmrun.halva.EvaluationState.EvaluationStateLift)
abstract EvaluationState(EvaluationStateSum) from EvaluationStateSum to EvaluationStateSum{
  static public var _(default,never) = EvaluationStateLift;
  public inline function new(self:EvaluationStateSum) this = self;
  @:noUsing static inline public function lift(self:EvaluationStateSum):EvaluationState return new EvaluationState(self);

  public function prj():EvaluationStateSum return this;
  private var self(get,never):EvaluationState;
  private function get_self():EvaluationState return lift(this);
}
class EvaluationStateLift{
  static public inline function lift(self:EvaluationStateSum):EvaluationState{
    return EvaluationState.lift(self);
  }
}