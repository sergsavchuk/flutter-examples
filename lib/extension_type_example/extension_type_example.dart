/// https://dart.dev/language/extension-types

void main() {
  const x = 5;

  print('Call foo of MyInt: ${MyInt(x).foo()}');
  print('Call bar of MyIntImpl: ${MyIntImpl(x).bar()}');

  // CANT do like this cause `x` have static type of `int` and `int` doesn't have `foo` method
  // print('Call foo of int: ${x.foo()}');
  // CANT do like this cause `x` have static type of `int` and `int` doesn't have `bar` method
  // print('Call bar of int: ${x.bar()}');

  // CAN do runtime cast of `int` to `MyInt` cause underlying value has `int` type
  print('Call foo of int runtime cast to MyInt: ${(x as MyInt).foo()}');
  print('MyInt becomes int at runtime: ${MyInt(x) is int}');
  // CAN do runtime cast of  `int` to `MyIntImpl` cause underlying value has `int` type
  print('Call bar of int runtime cast to MyIntImpl: ${(x as MyIntImpl).bar()}');
  print('MyIntImpl becomes int at runtime: ${MyInt(x) is int}');
  // CANT do runtime cast of `String` to `MyInt` cause it throws cast error
  // print('Call foo of String runtime cast to MyInt: ${('' as MyInt).foo()}');
  ///
  /// That's why it's dangerous to use runtime casts with extension types

  // CANT do like this cause `MyInt` and `int` are different static types, and `MyInt` doesn't have `+` operator
  // print('Sum of MyInt and int ${MyInt(x) + x}');
  // but CAN do like this cause we get underlying `int` value using implicit `val` getter
  print('Sum of MyInt.val and int: ${MyInt(x).val + x}');

  // CAN do like this cause `MyIntImpl` implements `int`, that's why it has `int operator(int other)`
  print('Sum of MyIntImpl and int: ${MyIntImpl(x) + x}');
  // CAN do like this cause `MyIntImpl` implements `int`, that's why we can treat it as `int`
  print('Sum of MyIntImpl and int: ${x + MyIntImpl(x)}');

  <int>[
    x,
    // CAN add `MyIntImpl` cause it implements `int`
    MyIntImpl(x),
    // CANT add `MyInt` cause doesn't implement `int`
    // MyInt(x),
  ];
}

extension type MyInt(int val) {
  String foo() => 'foo $val';
}

extension type MyIntImpl(int val) implements int {
  String bar() => 'bar $val';
}
