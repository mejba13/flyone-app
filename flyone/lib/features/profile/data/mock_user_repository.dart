import 'user_repository.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<Map<String, String>> getUserProfile() async {
    return {
      'name': 'Mejba Ahmed',
      'email': 'mejba@ramlit.com',
      'phone': '+62 812 3456 7890',
      'nationality': 'Indonesian',
      'passport': 'A12345678',
    };
  }
}
