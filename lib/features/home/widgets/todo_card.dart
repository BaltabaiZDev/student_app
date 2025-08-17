import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/data/controller/todo_controller.dart';
import '../../../data/model/todo_model.dart';
import 'edit_todo_bottom_sheet.dart';
import 'priority_display.dart';

class TodoCard extends GetView<TodoController> {
  final Todo todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            todo.complete
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: todo.complete ? Colors.greenAccent : Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  todo.description,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                PriorityDisplay(priority: todo.priority),
              ],
            ),
          ),
          IconButton(onPressed: ()=>controller.deleteTodo(todo.id), icon: Icon(Icons.delete)),
          IconButton(
            color: Colors.purpleAccent,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (_) => EditTodoBottomSheet(todo: todo),
              );
            },
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
    );
  }
}
