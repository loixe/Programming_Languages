(*Question 4.1*)
fun test1  x lst = x :: lst;
(*Question 4.2*)
fun test2 a [] = []
    |test2 a (b::bs) = [a] @ (test2 a bs);
(*Question 4.3*)
fun test2 f [] b = b
    |test2 f (a::y) b = f(a, test2 f y b);
(*Question 4.4*)
fun test2 f a [] = a
    |test2 f [] a = a
    |test2 f (x::xs) (b::bs) = f(b, test2 f xs bs);
(*Question 4.5*)
datatype ('a,'b) tree = Leaf of 'a
                        | Node of 'a * 'b;
fun test3 (Node(a, b)) f1 f2 = Node(b, (f2 (f2 (f1 a) b) a))
|   test3 (Leaf t) f1 f2 = Leaf t;






(*Question 5.1*)
exception NoItem;
fun get_index [] a = raise NoItem
|   get_index (b::bs) a =  if a = 0 then b else get_index bs (a-1);
get_index [1, 2, 3] 1;


(*Question 5.2*)
fun listsum x n = (foldl (fn (a, ax) => a + ax) 0 x) = n;
listsum [2,3,4] 5;
listsum [2,3,4] 9;

(*Question 5.3*)
exception Mismatch;
fun zip ((a::ax), (b::by)) = (a, b)::(zip (ax, by))
|   zip ([], []) = []
|   zip ([], a) = raise Mismatch
|   zip (a, []) = raise Mismatch;
zip ([1,2,3,4,5], ["a","b","c","d","e"]);

(*Question 5.4*)
fun unzip [] = ([], [])
|	unzip ((a,b)::tl) = 
	let val (ax, by) = unzip tl in (a::ax, b::by) end;
unzip [(1,"a"),(2,"b"),(3,"c"),(4,"d"),(5,"e")];

(*Question 5.5*)
fun bind (SOME x) (SOME y) f = SOME (f x y)
|	bind NONE (SOME y) f = NONE
|	bind (SOME x) NONE f = NONE
|	bind NONE NONE f = NONE;

fun add x y = x+y;
bind (SOME 4) (SOME 3) add;
bind (SOME 4) NONE add;

(*Question 5.6*)
fun getitem n [] = NONE
|   getitem 1 (a::ax) = (SOME a)
|	getitem n (a::ax) = if n<=0 then NONE else getitem (n-1) ax;
getitem 2 [1,2,3,4];
getitem 5 [1,2,3,4];
getitem ~1 [1,2,3,4];

(*Question 5.7*)
fun lookup ((s,i)::tl) x = 
	if s=x then SOME i else (lookup tl x)
|	lookup [] x = NONE;
lookup [("hello",1), ("world", 2)] "hello";
lookup [("hello",1), ("world", 2)] "world";
lookup [("hello",1), ("world", 2)] "he";





(*Question 6*)
functor MultiQ (multiq : sig
	type t
	val max : int
end) : sig
	type 'a mlqueue
	exception LevelNoExist
	exception Empty
	exception NotFound
	val maxlevel : int
	val new : multiq.t mlqueue
	val enqueue : multiq.t mlqueue -> int -> int -> multiq.t -> multiq.t mlqueue
	val dequeue : multiq.t mlqueue -> (multiq.t * multiq.t mlqueue)
	val move : (multiq.t -> bool) -> multiq.t mlqueue -> multiq.t mlqueue
	val atlevel : multiq.t mlqueue -> int -> (int * multiq.t) list
	val lookup : (multiq.t -> bool) -> multiq.t mlqueue -> int * int
	val isempty : multiq.t mlqueue -> bool
	val flatten : multiq.t mlqueue -> multiq.t list
end = struct

	type 'a mlqueue = (int * int * multiq.t) list
	exception LevelNoExist
	exception Empty
	exception NotFound
	val maxlevel = multiq.max
	val new = []

	fun enqueue ((l1, p1, a)::ax) l p e =
		if l<0 orelse l>maxlevel then raise LevelNoExist
		else if l<l1 orelse (l=l1 andalso p<p1)
		then (l, p, e) :: ((l1, p1, a)::ax)
		else (l1, p1, a) ::(enqueue ax l p e)
	|	enqueue [] l p e =
		if l<0 orelse l>maxlevel then raise LevelNoExist
		else [(l,p,e)]


	fun dequeue [] = raise Empty
	|	dequeue ((l, p, a)::ax) = (a, ax)

	fun move pred [] = []
	|	move pred ((l,p,a)::ax) = 
		if pred a andalso (l+1) <= maxlevel 
		then enqueue (move pred ax) (l+1) p a 
		else enqueue (move pred ax) l p a

	fun atlevel [] n = 
		if n>maxlevel orelse n<0 
		then raise LevelNoExist else []
	|	atlevel ((l, p, a)::ax) n = 
		if n>maxlevel orelse n<0 then raise LevelNoExist
		else if n=l then (p, a) :: (atlevel ax n)
		else atlevel ax n


	fun lookup pred ((l, p, a) :: ax) = 
		if pred a then (l, p) else (lookup pred ax)
	|	lookup pred [] = raise NotFound

	fun isempty [] =  true 
    |   isempty _ = false
	

	fun flatten [] = []
	|	flatten ((l, p, a) :: ax) = a::(flatten ax)
end;



