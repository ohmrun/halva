package eu.ohmrun.halva;

@:using(eu.ohmrun.halva.LVarLatticeData.LVarLatticeDataLift)
typedef LVarLatticeData<T> = RedBlackSet<LVarLatticeItemSum<T>>;

class LVarLatticeDataLift{
  public function get(self:LVarLatticeData<T>,activation_set:LVarLatticeData<T>):Pledge<HalvaFailure>{
    
  }
}