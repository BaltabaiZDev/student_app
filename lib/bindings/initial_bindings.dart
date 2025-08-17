import 'package:get/get.dart';

import '../data/repository/auth_repository.dart';
import '../data/repository/todo_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(TodoRepository());
  }

}