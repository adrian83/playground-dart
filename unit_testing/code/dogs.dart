import "dart:async";

import "package:test/test.dart";
import 'package:mockito/mockito.dart';

class Dog {
  String _name;
  Dog(this._name);
  String get name => _name;
  String toString() => "Dog {name:${_name}}";
}

class DogRepository {
  List<Dog> listDogs() {
    // returns dogs
    return new List<Dog>();
  }

  void saveDog(Dog dog) {
    // save dog
  }
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

class DogRepositoryMock extends Mock implements DogRepository {}

void main() {
  test("Dog's toString() method result should contain his name.", () {
    var name = "Snoopy";
    expect(new Dog(name).toString(), contains(name));
  });

  var dogRepositoryMock = new DogRepositoryMock();

  var dogService = new DogService(dogRepositoryMock);

  test("DogService should return list of dogs", () {
    // given
    var snoopy = new Dog("Snoopy");
    var dogs = new List();
    dogs.add(snoopy);

    when(dogRepositoryMock.listDogs()).thenReturn(dogs);
    // when
    var result = dogService.listDogs();

    verify(dogRepositoryMock.listDogs());
    // then
    expect(result.value[0], completion(equals(snoopy)));
  });

  test("DogService should throw Error when trying to save null", () {
    expect(() => dogService.saveDog(null), throwsArgumentError);
    verifyNever(dogRepositoryMock.saveDog(null));
  });

  test("DogService should store dog", () {
    // given
    var snoopy = new Dog("Snoopy");

    // when
    dogService.saveDog(snoopy);

    verify(dogRepositoryMock.saveDog(snoopy));
  });
}
