import 'package:get/get.dart';

import '../../utils/http/http_helper.dart';
import '../model/todo_model.dart';

class TodoRepository extends GetxController {
  static TodoRepository get instance => Get.find();

  Future<List<Todo>> fetchTodos() async {
    final data = await THttpHelper.getList('todos');
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> addTodo(Todo data) async {
    try {
      await THttpHelper.post('todos/todo', data.toJson());
      Get.snackbar("Success", "Todo added");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await THttpHelper.delete('todos/todo/$id');
      Get.snackbar("Success", "Todo deleted");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await THttpHelper.put('todos/todo/${todo.id}', {
        'title': todo.title,
        'description': todo.description,
        'priority': todo.priority,
        'complete': todo.complete,
      });
    } catch (e) {
      Get.snackbar('Сервер дұрыс жауап қайтармады', e.toString());
    }
  }
}
