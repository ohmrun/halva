package eu.ohmrun.halva;

enum LVarOp<T>{
  Put(v:T);
  Get(activation_set:ActivationSet<T>>);
  Freeze;
  //Listen(fn:(ActivationSet<T>->Void)->(Void->Void));
}