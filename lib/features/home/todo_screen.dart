import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/features/home/widgets/todo_card.dart';
import '../../../data/controller/auth_controller.dart';
import '../../../data/controller/todo_controller.dart';
import '../../data/model/todo_model.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final todoController = Get.put(TodoController());

    return Scaffold(
      backgroundColor: const Color(0xFF5E768D),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Бас бет',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddTodoDialog(),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),

          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: todoController.loadTodos,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (todoController.todos.isEmpty) {
          return const Center(
            child: Text(
              'Тапсырмалар жоқ',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withAlpha(50)),
                ),
                child: ListView.builder(
                  itemCount: todoController.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoController.todos[index];
                    return TodoCard(todo: todo);
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _priority = 1;

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Жаңа тапсырма қосу"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Тақырып'),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Сипаттама'),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            value: _priority,
            items: List.generate(5, (i) => i + 1).map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text("Маңыздылық: $value"),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _priority = val);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Болдырмау"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text("Қосу"),
          onPressed: () {
            final newTodo = Todo(
              id: 0,
              title: _titleController.text,
              description: _descController.text,
              priority: _priority,
              complete: false,
            );
            todoController.addTodo(newTodo);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
