/// https://dart.dev/null-safety/understanding-null-safety

void main() {
  WorkingWithNullablesExample().foo();
}

class WorkingWithNullablesExample {
  String? nullableField = 'notNull';

  void foo() {
    if (nullableField != null) {
      // The commented line below will not compile cause compiler can't be sure
      // that field value is not changed between check and usage.
      // print(nullableField.length);

      // So you should neither use null-aware operator or null
      // assertion operator(in that case you should be completely sure there
      // is not null value inside)
      print("I'm not null ${nullableField?.length}");
      print("And i'm completely confident in that ${nullableField!.length}");

      // Sometimes you may want to replace a result with a default value if a
      // variable is null, in that case you can use inline null check.
      print(
          "Inline null check ${nullableField?.length != null ? nullableField?.length : 0}");

      // But it looks tedious, so there is special if-null-operator.
      print("Using if-null-operator ${nullableField?.length ?? 0}");
    }

    // Another way to solve this problem is to use a local variable cause
    // compiler can analyze the control flow for local variables.
    String? localNullable = nullableField;
    if (localNullable != null) {
      print(
          "I'm localNullable and I was checked for null ${localNullable.length}");
    }

    // You can also create functions with a return type of Never
    // so the compiler will know that the code after if statement is
    // unreachable when localNullable contains a null value.
    if (localNullable == null) {
      functionThatThrows('localNullable is null error!');
    }
    print(
        "There is no need now to do check for null value: ${localNullable.length}");
  }

  Never functionThatThrows(String error) {
    throw error;
  }
}
