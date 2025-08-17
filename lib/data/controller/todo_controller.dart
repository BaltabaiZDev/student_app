import 'dart:developer';

import 'package:get/get.dart';

import '../model/todo_model.dart';
import '../repository/todo_repository.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  final _repo = TodoRepository();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void deleteTodo(int id) async {
    try {
      isLoading.value = true;
      await _repo.deleteTodo(id);
      todos.removeWhere((todo) => todo.id == id);
      todos.refresh();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
  void addTodo(Todo data) async {
    try {
      isLoading.value = true;
      await _repo.addTodo(data);
      await loadTodos();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loadTodos() async {
    try {
      isLoading.value = true;
      final data = await _repo.fetchTodos();
      todos.assignAll(data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  void updateTodo(Todo updatedTodo) async {
    try {
      isLoading.value = true;
      await _repo.updateTodo(updatedTodo);
      int index = todos.indexWhere((t) => t.id == updatedTodo.id);
      if (index != -1) {
        todos[index] = updatedTodo;
        todos.refresh();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
      Get.snackbar('Қате', 'Жаңарту мүмкін болмады,$e');
    }
  }
}
