import "package:test/test.dart";
import "package:mockito/mockito.dart";

import "dogs.dart";

class DogRepositoryMock extends Mock implements DogRepository {}

void main() {
  test("toString() method result should contain dog's name", () {
    var name = "Snoopy";

    expect(new Dog(name).toString(), contains(name));
  });

  // setup
  var dogRepositoryMock = new DogRepositoryMock();
  var dogService = new DogService(dogRepositoryMock);

  test("listDogs should return list of dogs", () async {
    // given
    var snoopy = new Dog("Snoopy");
    var dogs = new List();
    dogs.add(snoopy);

    when(dogRepositoryMock.listDogs()).thenReturn(dogs);

    // when
    var result = await dogService.listDogs();

    // then
    verify(dogRepositoryMock.listDogs());

    expect(result[0], equals(snoopy));
  });

  test("saveDog should throw error when invoked with null parameter", () {
    expect(() => dogService.saveDog(null), throwsArgumentError);
    verifyNever(dogRepositoryMock.saveDog(null));
  });

  test("saveDog should store dog when invoked with valid parameter", () {
    // given
    var snoopy = new Dog("Snoopy");

    // when
    dogService.saveDog(snoopy);

    // then
    verify(dogRepositoryMock.saveDog(snoopy));
  });
}
