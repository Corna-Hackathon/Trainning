import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Option "mo:base/Option";

actor {

  public func nat_to_nat8(n: Nat) : async Nat8 {
    return Nat8.fromNat(n);
  };

  public func max_number_with_n_bits(n :Nat) : async Nat {
    return 2**n;
  };

  public func decimal_to_bits(n: Nat) : async Text {
    var x : Nat = n;
    var ans : Text = "";
    while(x!=1){
      ans := Nat.toText(x%2) # ans;
      x := x/2;
    };
    ans := "1" # ans;
    return ans;
  };

  let cap_char = func (c: Char) : Char {
    return Char.fromNat32(Char.toNat32(c)-32);
  };

  public func capitalize_character(c : Char) : async Char {
  	// return(Char.fromNat32(Char.toNat32(c)-32));
    return cap_char(c);
  };

  public func capitalize_text(t : Text) : async Text {
    // var ans : Text = "";
    // for(char in t.chars()){
    //   ans := ans # Char.toText(await capitalize_character(char));
    // };
    // return ans;
    return Text.map(t, cap_char);
  };
  
  public func is_inside(t : Text, c : Char) : async Bool {
    // for(char in t.chars()){
    //   if(char==c){
    //     return true;
    //   };
    // };
    // return false;
    return Text.contains(t, #char c);
  };
  
  public func trim_whitespace(t : Text) : async Text {
    let whitespace : Char = ' ';
    return Text.trimEnd(Text.trimStart(t,#char whitespace), #char whitespace);
  };

  public func duplicated_character(t: Text) : async Text {
    var lastChar : Char = ' ';
    for (char in t.chars()){
      if(char==lastChar){
        return Char.toText(char);
      };
      lastChar := char;
    };
    return t;
  };
  
  public func size_in_bytes(t: Text) : async Nat {
    var size : Nat = 0;
    for (char in t.chars()){
      size += Nat32.toText(Char.toNat32(char)).size();
    };
    return size
  };

  public func bubble_sort(array : [Nat]) : async [Nat] {
    let newArr : [var Nat] = Array.thaw<Nat>(array);
     for (min in Iter.range(0, newArr.size()-2)){
      for (selection in Iter.range(min, newArr.size()-1)){
        if(newArr[min] > newArr[selection]){
          var tmp : Nat = newArr[min];
          newArr[min] := newArr[selection];
          newArr[selection] := tmp;
        };
      };
    };
    return Array.freeze<Nat>(newArr);
  };

  public func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat {
    Option.get(n, m)
  };  

  public func day_of_the_week (n: Nat) : async ?Text {
    let days : [Text] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    return if(n < 7) Option.make(days[n]) else null;
  };

  public func populate_array (array: [?Nat]) : async [Nat] {
    let nat_opt = func (n: ?Nat) : Nat {
      Option.get(n, 0);
    };
    return Array.map(array, nat_opt);
  };
  
  public func sum_of_array (array: [Nat]) : async Nat {
    var sum : Nat = 0;
    let sum_add = func (n: Nat) : Nat {
      sum+=n;
      return n;
    };
    let tmparr = Array.map(array, sum_add);
    return sum;
  };

  public func squared_array (array : [Nat]): async [Nat] {
    let squared_array = func (n: Nat) : Nat {
      return n*n;
    };
    return Array.map(array, squared_array);
  };

  public func increase_by_index (array : [Nat]) : async [Nat] {
    let increase_by_index = func (n: Nat, index: Nat) : Nat {
      return n+index;
    };
    return Array.mapEntries(array, increase_by_index);
  };

  func contains<A> (arr :[A], value : A, f: (A, A) -> Bool) : Bool {
    for (a in arr.vals()){
      if(f(a, value)){
        return true;
      };
    };
    return false;
  };
};
 