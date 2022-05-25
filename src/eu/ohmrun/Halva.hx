package eu.ohmrun;

typedef HalvaFailure 			        = stx.fail.HalvaFailure;
typedef HalvaFailureSum 	        = stx.fail.HalvaFailure.HalvaFailureSum;

typedef Item<T> 			            = eu.ohmrun.halva.lvar.Item<T>;
typedef ItemSum<T> 	              = eu.ohmrun.halva.lvar.Item.ItemSum<T>;

typedef LVarLatticeOps<T> 			  = eu.ohmrun.halva.LVarLatticeOps<T>;
typedef LVarLatticeOpsCls<T> 	    = eu.ohmrun.halva.LVarLatticeOps.LVarLatticeOpsCls<T>;
typedef LVarLatticeOpsApi<T> 	    = eu.ohmrun.halva.LVarLatticeOps.LVarLatticeOpsApi<T>;

typedef EvaluationState 			    = eu.ohmrun.halva.EvaluationState;
typedef EvaluationStateSum 	      = eu.ohmrun.halva.EvaluationState.EvaluationStateSum;

typedef EvaluationContext 			  = eu.ohmrun.halva.EvaluationContext;
typedef EvaluationContextDef 	    = eu.ohmrun.halva.EvaluationContext.EvaluationContextDef;

typedef Decl                      = eu.ohmrun.halva.Decl;
typedef DeclSum                   = eu.ohmrun.halva.Decl.DeclSum;

typedef Knuckle                   = eu.ohmrun.halva.Knuckle;
typedef LVarLatticeData<T>        = eu.ohmrun.halva.LVarLatticeData<T>;

typedef LVarDef<T>                = eu.ohmrun.halva.LVar.LVarDef<T>;
typedef LVar<T>                   = eu.ohmrun.halva.LVar<T>;

typedef LVarOp<T>                 = eu.ohmrun.halva.LVarOp<T>;
typedef ActivationSet<T>          = eu.ohmrun.halva.ActivationSet<T>;
 
class StubItemComparable{
  static public function Item<T>(stub:stx.assert.stub.Comparable,inner:Comparable<T>):Comparable<Item<T>>{
    return new stx.assert.halva.lvar.comparable.Item(inner);
  } 
}
