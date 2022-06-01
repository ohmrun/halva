typedef AccountDef<T> = LinkedList<Journal<T>>;

enum Knuckle{
  Ordinal(idx:UInt);
  Nominal(str:String);
}
enum JournalSum<T>{
  Record(knuckle:Knuckle,account:Junction<Account<T>>);
  Figure(figure:LVar<T>);//Figure(TOP) acts as a boundary
}
enum LVarSum<T>{
  BOT;
  HAS(v:T);
  TOP;
} 
enum JunctionSum<T>{
  There(r:Register);
  Whole(v:T);
}