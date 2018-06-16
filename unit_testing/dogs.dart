import "dart:async";

class Dog {
  String _name;
  Dog(this._name);
  String get name => _name;
  String toString() => "Dog {name:${_name}}";
}

class DogRepository {
  List<Dog> listDogs() => new List<Dog>(); // get dogs from DB
  void saveDog(Dog dog) {} // save dog into DB
}

class DogService {
  DogRepository _repo;
  DogService(this._repo);

  Future<List<Dog>> listDogs() async {
    return _repo.listDogs();
  }

  void saveDog(Dog dog) {
    if (dog == null) {
      throw new ArgumentError("Dog cannot be null");
    }
    _repo.saveDog(dog);
  }
}
