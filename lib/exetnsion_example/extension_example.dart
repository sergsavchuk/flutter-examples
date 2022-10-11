/// https://medium.com/dartlang/extension-methods-2d466cd8b308

void main() {
  // Explicit invocation of extension method.
  print(ExampleExtension('1').multiply(3)); // -> 111

  // Implicit invocation of extension method.
  print('1'.multiply(3)); // -> 111

  print('hello' % 4);

  // If two extensions declare same method you get a conflict.
  // '2'.conflictingPrint(); // -> error
  // To resolve it you can invoke extension method explicitly:
  ExampleExtension('str').conflictingPrint();
  ExampleExtension2('str').conflictingPrint();
}

extension ExampleExtension on String {
  // You CAN'T declare instance fields, because extension can't be
  // instantiated.
  // int myIntField = 0; // -> error

  // But you CAN declare static fields, because they don't need an instance.
  static int myStaticInt = 2;

  // You CAN'T declare constructor, because extension can't be instantiated.
  // ExampleExtension(); // -> error

  String multiply(int times) {
    // You can use this inside as if you were inside the class you are
    // extending.
    return this * times;
  }

  // You CAN declare getter/setter
  int get myLength => length;

  // You CAN declare operator.
  String operator %(int len) {
    return substring(0, len);
  }

  void conflictingPrint() {
    print('1: ${this}');
  }
}

extension ExampleExtension2 on String {
  void conflictingPrint() {
    print('2: ${this}');
  }
}
