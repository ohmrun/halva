using eu.ohmrun.Halva;

class Main {
	static function main() {
		
	}
}






// class InvLVarLattice extends LVarLatticeCls<Int>{
// 	public function unit():LVarData<Int>{
// 		return LVarData.make0(Comparable.Int());
// 	}
// 	/**
// 		PRODUCT
// 		glb
// 	**/
// 	public function meet(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>{

// 	}
// 	/**
// 		SUM
// 		lub
// 	**/
// 	public function join(l:LVarLatticeData<T>,r:LVarLatticeData<T>):LVarLatticeData<T>{

// 	}
// }

// typedef HalvaStoreDef<T> = Map<Location,LVarLatticeData<T>>;
// abstract HalvaStore<T>(HalvaStoreDef<T>) from HalvaStoreDef<T> to HalvaStoreDef<T>{
// 	static var counter(get,null) : Counter;
// 	public function get_counter(){
// 		return counter == null ? Counter.unit(): counter;
// 	}
// 	public function new(self) this = self;
// 	@:noUsing static public function lift<T>(self:HalvaStoreDef<T>):HalvaStore<T> return new HalvaStore(self);

// 	public function prj():HalvaStoreDef<T> return this;
// 	private var self(get,never):HalvaStore<T>;
// 	private function get_self():HalvaStore<T> return lift(this);

// 	public function create(with:Comparable<T>):Location{
// 		final location = counter.next(); 
// 		this.set(
// 			location,
// 			RedBlackTree.make(with).set(BOTTOM)
// 		);
// 		return location;
// 	}
// 	public function update(location:Location,state:LVarLatticeData<T>){

// 	}
// }
