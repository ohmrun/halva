package eu.ohmrun.halva.core;

enum ExprSum{	
  EVar(name:String);
  EVal(v:Value);
	EApp(eI:Expr,eII:Expr);
	EGet(eI:Expr,eII:Expr); 
	EPut(reg:Register,and:Expr);
  ENew;
  EFreeze(e:Expr,?after_with:Couple<Expr,Expr>);
  //FreezeLoc(l:Location,sets:Cluster<RedBlackSet<Decl>>,) 
}
typedef ExprDef =                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       {
  final expr    : Expr;
  final stack   : Cluster<EvaluationState>;
}
@:using(eu.ohmrun.halva.core.Expr.ExprLift)
abstract Expr(ExprDef) from ExprDef to ExprDef{
  static public var _(default,never) = ExprLift;
  public inline function new(self:ExprDef) this = self;
  @:noUsing static inline public function lift(self:ExprDef):Expr return new Expr(self);

  public function prj():ExprDef return this;
  private var self(get,never):Expr;
  private function get_self():Expr return lift(this);
}
class ExprLift{
  static public inline function lift(self:ExprDef):Expr{
    return Expr.lift(self);
  }
}