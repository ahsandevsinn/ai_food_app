import 'package:ai_food/Practice/list_management_provider.dart';
import 'package:ai_food/Practice/task_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final practiceProvider =
    Provider.of<ListManagementProvider>(context, listen: true);
    return AlertDialog(
      title: const Text("Add New Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final newName = _nameController.text;
            final newDescription = _descriptionController.text;

            if (newName.isNotEmpty && newDescription.isNotEmpty) {
              practiceProvider.addTask(TaskParameters(
                name: newName,
                description: newDescription,
                status: Status.incomplete,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}



class EditTaskDialog extends StatefulWidget {
  final TaskParameters task;

  const EditTaskDialog({super.key, required this.task});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final practiceProvider =
    Provider.of<ListManagementProvider>(context, listen: true);
    return AlertDialog(
      title: const Text("Edit Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final newName = _nameController.text;
            final newDescription = _descriptionController.text;

            if (newName.isNotEmpty && newDescription.isNotEmpty) {
              widget.task.name = newName;
              widget.task.description = newDescription;
              practiceProvider.updateTaskNameAndDescription(widget.task, newName, newDescription);
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}