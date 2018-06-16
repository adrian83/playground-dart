import "package:test/test.dart";

import "isolates.dart";

class TxtTask extends Task<String> {
  String _txt;
  TxtTask(this._txt);
  String execute() => this._txt;
}

class IntSumTask extends Task<int> {
  int _a, _b;
  IntSumTask(this._a, this._b);
  int execute() => this._a + this._b;
}


main() async {

  test("future with string should be returned when TxtTask is executed", () async {
    var expectedTxt = "Hello World";

    var resultF = executeInIsolate(new TxtTask(expectedTxt));

    expect(await resultF, equals(expectedTxt));
  });

  test("future with sum of two integers should be returned when IntSumTask is executed", () async {
    var a = 2;
    var b = 7;
    var expectedSum = a + b;

    var resultF = executeInIsolate(new IntSumTask(a, b));

    expect(await resultF, equals(expectedSum));
  });

}
