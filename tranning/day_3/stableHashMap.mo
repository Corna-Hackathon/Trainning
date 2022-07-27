import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

actor{
    stable var upgradeCanisters : [(Principal, Nat)] = [];
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    system func preupgrade() {
        upgradeCanisters := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        favoriteNumber := HashMap.fromIter<Principal, Nat>(upgradeCanisters.vals(), 10, Principal.equal, Principal.hash);
        upgradeCanisters := [];
    };

    public shared({caller}) func add_favorite_number(n: Nat) : async Text {
    switch(favoriteNumber.get(caller)) {
      case (null) {
        favoriteNumber.put(caller, n);
        return "You've successfully registered your number";
      }; case (_) {
        return "You've already registered your number";
      }
    };
  };
  
    public shared({caller}) func show_favorite_number() : async ?Nat {
        return favoriteNumber.get(caller);
    };

  public shared({caller}) func update_favorite_number(n: Nat) : async Text {
    switch(favoriteNumber.replace(caller, n)) {
      case (null) {
        return "You haven't registered your number";
      }; case (_) {
        return "You've successfully updated your number";
      }
    };
  };

  public shared({caller}) func delete_favorite_number() : async Text {
    switch(favoriteNumber.remove(caller)) {
      case (null) {
        return "You haven't registered your number";
      }; case (_) {
        return "You've successfully deleted your number";
      }
    };
  };
}