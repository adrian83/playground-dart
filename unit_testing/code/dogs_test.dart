import "dart:async";

import "package:test/test.dart";
import "package:mockito/mockito.dart";

import "dogs.dart";


class DogRepositoryMock extends Mock implements DogRepository {}

void main() {
  test("Dog's toString() method result should contain his name.", () {
    var name = "Snoopy";
    expect(new Dog(name).toString(), contains(name));
  });

  var dogRepositoryMock = new DogRepositoryMock();

  var dogService = new DogService(dogRepositoryMock);

  test("DogService should return list of dogs", () async {
    // given
    var snoopy = new Dog("Snoopy");
    var dogs = new List();
    dogs.add(snoopy);

    when(dogRepositoryMock.listDogs()).thenReturn(dogs);
    // when
    var result = await dogService.listDogs();

    verify(dogRepositoryMock.listDogs());
    // then
    expect(result[0], equals(snoopy));
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
