package eu.ohmrun;

typedef HalvaFailure 			        = stx.fail.HalvaFailure;
typedef HalvaFailureSum 	        = stx.fail.HalvaFailure.HalvaFailureSum;

typedef Account<T> 			          = eu.ohmrun.halva.Account<T>;
typedef AccountSum<T> 	          = eu.ohmrun.halva.Account.AccountSum<T>;

typedef Assembly<Data,Item> 			= eu.ohmrun.halva.Assembly<Data,Item>;
typedef AssemblySum<Data,Item> 	  = eu.ohmrun.halva.Assembly.AssemblySum<Data,Item>;

typedef Journal<T> 			          = eu.ohmrun.halva.Journal<T>;
typedef JournalSum<T> 	          = eu.ohmrun.halva.Journal.JournalSum<T>;

typedef Junction<T> 			        = eu.ohmrun.halva.Junction<T>;
typedef JunctionSum<T> 	          = eu.ohmrun.halva.Junction.JunctionSum<T>;

// typedef Item<T> 			          = eu.ohmrun.halva.lvar.Item<T>;
// typedef ItemSum<T> 	          = eu.ohmrun.halva.lvar.Item.ItemSum<T>;

// typedef EvaluationState 			  = eu.ohmrun.halva.EvaluationState;
// typedef EvaluationStateSum 	  = eu.ohmrun.halva.EvaluationState.EvaluationStateSum;

// typedef EvaluationContext 			= eu.ohmrun.halva.EvaluationContext;
// typedef EvaluationContextDef 	= eu.ohmrun.halva.EvaluationContext.EvaluationContextDef;

typedef Knuckle                   = eu.ohmrun.halva.Knuckle;

//typedef LVarDef<T>                = eu.ohmrun.halva.LVar.LVarDef<T>;
// typedef LVar<T>                   = eu.ohmrun.halva.LVar<T>;

//typedef LVarOp<T>                 = eu.ohmrun.halva.LVarOp<T>;
//typedef ActivationSet<T>          = eu.ohmrun.halva.ActivationSet<T>;

class StubItemComparable{
  // static public function Item<T>(stub:stx.assert.stub.Comparable,inner:Comparable<T>):Comparable<Item<T>>{
  //   return new stx.assert.halva.lvar.comparable.Item(inner);
  // } 
}
