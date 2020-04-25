import 'package:caramelseed/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const User user = User(name: "name", lastname: "lastname");

  test(
    'should return user full name',
    () async {
      // act
      final userFullName = user.getUserFullName();
      // assert
      expect(userFullName, '${user.name} ${user.lastname}');
    },
  );
}
