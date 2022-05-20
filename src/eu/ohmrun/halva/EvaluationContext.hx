package eu.ohmrun.halva;

typedef EvaluationContextDef = {
	final handled : Cluster<Decl>;
  final state   : EvaluationState; 
  final stack   : Cluster<EvaluationState>;
}
@:using(eu.ohmrun.halva.EvaluationContext.EvaluationContextLift)
@:forward abstract EvaluationContext(EvaluationContextDef) from EvaluationContextDef to EvaluationContextDef{
  static public var _(default,never) = EvaluationContextLift;
  public inline function new(self:EvaluationContextDef) this = self;
  @:noUsing static inline public function lift(self:EvaluationContextDef):EvaluationContext return new EvaluationContext(self);

  public function prj():EvaluationContextDef return this;
  private var self(get,never):EvaluationContext;
  private function get_self():EvaluationContext return lift(this);
}
class EvaluationContextLift{
  static public inline function lift(self:EvaluationContextDef):EvaluationContext{
    return EvaluationContext.lift(self);
  }
} 