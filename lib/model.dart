import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final Address address;

  const Person({
    required this.name,
    required this.age,
    required this.address,
  });

  @override
  String toString() {
    return 'Person{name: $name, age: $age, address: $address}';
  }
}

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  final String street;
  @HiveField(1)
  final int house;

  const Address({
    required this.street,
    required this.house,
  });

  @override
  String toString() {
    return 'Address{street: $street, house: $house}';
  }
}
