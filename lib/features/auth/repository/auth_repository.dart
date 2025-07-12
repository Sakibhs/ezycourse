import 'package:ezycourse/services/api_services.dart';

import '../model/user_model.dart';

class AuthRepository {
  final APIServices apiServices = APIServices();

  Future<dynamic> login(String email, String password) async {
    final response = await apiServices.post('student/auth/login', {
      'email': email.trim(),
      'password': password.trim(),
    });
    return response['token'];
  }


  Future<bool> logout() async {
    const endpoint = "student/auth/logout";
    final response = await apiServices.post(endpoint, {});
    return response != null;
  }


}