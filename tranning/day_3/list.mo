module {
    public type List<T> = ?(T, List<T>);

    public func is_null<T>(list: List<T>) : Bool {
        switch(list){
            case (null) return true;
            case (?list) return false;
        }
    };

    public func last<T>(l: List<T>) : ?T {
        switch(l){
            case null return null;
            case (?(x,null)) return ?x;
            case (?(_,t)) return last(t);
        }
    };

    public func size<T>(l: List<T>) : Nat {
        switch(l){
            case null return 0;
            case (?(x,null)) return 1;
            case (?(_,t)) return size(t) + 1;
        }
    };
    
    public func get<T>(l : List<T>, n : Nat) : ?T{
        switch(n, l){
            case (_, null) return null;
            case (0, ?(x,_)) return ?x;
            case (_, ?(_,t)) return get(t, n-1);
        }
    }
}