package eu.ohmrun.halva.lvar.term;

import stx.schema.SType in TSType;

typedef STypeDef = LVar<TSType>;

abstract SType(STypeDef) from STypeDef to STypeDef{
  public function new(){
    this = new Pure(new stx.assert.schema.type.comparable.SType()).prj();
  }
}