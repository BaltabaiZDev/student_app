import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/login_screen.dart';
import '../../features/home/todo_screen.dart';
import '../../utils/http/http_helper.dart';
import '../model/todo_model.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final _storage = GetStorage();


  @override
  void onInit() {
    super.onInit();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final accessToken = await _storage.read('access_token');

    if(accessToken != null){
      Get.offAll(() => TodoScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await THttpHelper.postForm('auth/token', {
        'username': username,
        'password': password,
      });


      final accessToken = response['access_token'];
      log(accessToken);
      await _storage.write('access_token', accessToken);

      await screenRedirect();
    } catch (e){
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.remove('access_token');
    Get.offAll(() => LoginScreen());
  }

}
