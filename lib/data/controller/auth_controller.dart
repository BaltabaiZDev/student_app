import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final AuthRepository _repo = AuthRepository();

  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      await _repo.login(username, password);
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
  }

}
