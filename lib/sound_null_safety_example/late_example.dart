/// https://dart.dev/null-safety/understanding-null-safety#late-variables

import 'dart:io';

void main() {
  final instance = LateExample()..init();
  print("I'm late variable and my value is ${instance.myInt}");
  print("I'm late final variable and my value is ${instance.myFinalInt}\n");

  try {
    instance.myFinalInt = 43;
  } catch (e) {
    print('Attempting to change value of a late final variable throws the $e');
  }

  final instance2 = LateExample();
  try {
    instance2.myInt;
  } catch (e) {
    print(
        'Attempting to access an uninitialized late variable throws the $e\n');
  }

  sleep(const Duration(milliseconds: 500));
  print("With lazy initialization, the variable will only be "
      "initialized the first time it is accessed:");
  print("instance creation timestamp - "
      "${instance.creationTime % 10000}"
      ", myLazilyInitializedInt creation timestamp - "
      "${instance.myLazilyInitializedInt % 10000}\n");

  instance.localLazyInit();
}

class LateExample {
  /// Late modifier allows to define not initialized non-null fields.
  late int myInt;

  /// You can also use late with final field.
  late final int myFinalInt;

  final creationTime = DateTime.now().millisecondsSinceEpoch;

  /// You can use late to lazy init fields.
  late final int myLazilyInitializedInt = lazyInit();

  void init() {
    myInt = 42;
    myFinalInt = 4242;
  }

  int lazyInit() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  void localLazyInit() {
    print('You can use lazy init event with local variables:');

    late int localLazyInt = lazyInit();
    print(
        'function started - ${DateTime.now().millisecondsSinceEpoch % 10000}');

    sleep(const Duration(milliseconds: 500));

    print('local lazy int created - ${localLazyInt % 10000}');
  }
}
