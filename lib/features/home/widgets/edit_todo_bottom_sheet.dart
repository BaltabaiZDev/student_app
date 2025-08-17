import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/features/home/widgets/todo_complete_checkbox.dart';

import '../../../data/controller/todo_controller.dart';
import '../../../data/model/todo_model.dart';
import 'todo_priority_dropdown.dart';

class EditTodoBottomSheet extends StatefulWidget {
  final Todo todo;

  const EditTodoBottomSheet({super.key, required this.todo});

  @override
  State<EditTodoBottomSheet> createState() => _EditTodoBottomSheetState();
}

class _EditTodoBottomSheetState extends State<EditTodoBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late int priority;
  late bool complete;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
    priority = widget.todo.priority;
    complete = widget.todo.complete;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Тапсырманы өзгерту',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Тақырып',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Сипаттама',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            TodoPriorityDropdown(
              value: priority,
              onChanged: (val) => setState(() => priority = val),
            ),
            TodoCompleteCheckbox(
              value: complete,
              onChanged: (val) => setState(() => complete = val),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty || description.isEmpty) {
                  Get.snackbar(
                    'Қате',
                    'Барлық жолдарды толтырыңыз',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }

                final updatedTodo = widget.todo.copyWith(
                  title: title,
                  description: description,
                  priority: priority,
                  complete: complete,
                );

                controller.updateTodo(updatedTodo);
                Get.back();
              },
              child: const Text('Сақтау'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
