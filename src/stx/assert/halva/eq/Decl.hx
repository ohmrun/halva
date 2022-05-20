package eu.ohmrun.stx.assert.halva.eq;

import eu.ohmrun.halva.Decl in TDecl;

class Decl<T> extends stx.assert.Eq.EqCls<TDecl>{
  
  public function new(){
  }
  public function comply(lhs:TDecl,rhs:TDecl){
    // return switch([lhs,rhs]){
    //   [HDSchema(l),HDSchema(r)] : stx.
    //   default : Eq.EnumValueIndex().comply(lhs,rhs);
    // } 
    return throw UNIMPLEMENTED;
  }
}
