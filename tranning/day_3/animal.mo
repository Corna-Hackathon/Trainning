module {
    public type Animal = {
        specie: Text;
        energy: Nat;
    };
    
    public func animal_sleep(animal : Animal) : Animal {
        let newStateAnimal : Animal = {
            specie = animal.specie;
            energy = animal.energy + 10;
        };

        return newStateAnimal
    };
}