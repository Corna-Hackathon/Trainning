import Text "mo:base/Text";
import List "mo:base/List";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";
import People "custom";
import Animal "animal";

actor {
    public type Humanity = People.Humanity;
    public type Animal = Animal.Animal;
    public type List<T> = ?(T, List<T>);

    let anonymous = Principal.fromText("2vxsx-fae");
    var animalList : List<Animal> = List.nil();
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    stable var counter : Nat = 0;
    stable var versionNumber : Nat = 0;
    versionNumber += 1;

    let test : Humanity = {
        name = "Paru";
        percent = 5;
    };

    public func fun() : async Text {
        return test.name;
    };

    public func create_animal_then_takes_a_break(specie: Text, energy: Nat) : async Animal {
        let animal : Animal = {
            specie = specie;
            energy = energy;
        };
        return Animal.animal_sleep(animal);
    };

    public func push_animal(animal: Animal) {
        nimalList := List.push(animal, animalList);
    };

    public func get_animal() : async List<Animal> {
        return animalList;
    };

    public shared(msg) func is_anonymous() : async Bool {
        let principal_caller = msg.caller;
        return(principal_caller == anonymous);
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

    public func deposit_cycles() : async Nat {
        return Cycles.accept(Cycles.available());
    };

    public func withdraw_cycles(n: Nat) {
        return Cycles.add(n);
    };

    public func show_version() : async Nat {
        return versionNumber;
    };

    // Counter
    public func increment_counter (n : Nat) : async Int {
        counter += n;
        return counter;
    };

    public func clear_counter () : async Int {
        counter := 0;
        return counter;
    };

};
