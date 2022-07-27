import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor {
  var counter : Int = 0;
  var removeValue = 0;

  public func add (m : Nat, n : Nat) : async Nat {
    m + n;
  };
  
  public func square (n : Nat) : async Nat {
    n * n;
  };

  public func days_to_second (day : Int) : async Int {
    day * 86400;
  };

  public func increment_counter (n : Nat) : async Int {
    counter += n;
    return counter;
  };

  public func clear_counter () : async Int {
    counter := 0;
    return counter;
  };

  public func divide (n : Nat, m : Nat) : async Bool {
    return n%m == 0;
  };

  public func sum_of_array (arr : [Nat]) : async Nat {
    var sum : Nat  = 0;
    for (value in arr.vals()) {
      sum += value
    };
    return sum;
  };

  public func maximum (arr : [Nat]) : async Nat {
    var max : Nat = 0;
    for (value in arr.vals()){
      max := if(value > max) value else max;
    };
    return max;
  };

  public func remove_from_array (arr : [Nat], n : Nat) : async [Nat] {
    Array.filter(arr, func(val : Nat) : Bool {n != val});
  };

  func swap(&)

  public func selection_sort(arr : [Nat]) : async [Nat] {
    let newArr : [var Nat] = Array.thaw<Nat>(arr);

    for(i in Iter.range(0, newArr.size())) { //size == len()
      var min~ = i;
      for(j in Iter.range(i+1, newArr.size()-1)) {
        if (arr[min] > arr[j]) {
          min := j;
        };
      };
      let temp : Nat = newArr[i];
      newArr[i] := newArr[min];
      newArr[min] := temp;
      Debug.print(debug_show(newArr));
    };
    
    return Array.freeze<Nat>(newArr);
  }
  
};
