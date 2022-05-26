package eu.ohmrun.halva.core;

enum ValueSum{
  VNil;
  VDecl(d:Decl);
  VMemo(m:Memo<Decl>);
  VRegister(reg:Register);
  VThreshold(set:RedBlackSet<Memo<Decl>>);
  VEvent(set:RedBlackSet<Decl>);  
  VLambda(name:String,expr:Expr);//TODO ?
}

@:using(eu.ohmrun.halva.core.Value.ValueLift)
abstract Value(ValueSum) from ValueSum to ValueSum{
   static public var _(default,never) = ValueLift;
   public inline function new(self:ValueSum) this = self;
   @:noUsing static inline public function lift(self:ValueSum):Value return new Value(self);
 
   public function prj():ValueSum return this;
   private var self(get,never):Value;
   private function get_self():Value return lift(this);
}
class ValueLift{
   static public inline function lift(self:ValueSum):Value{
    return Value.lift(self);
  }
}