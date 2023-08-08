import 'package:ai_food/Practice/list_management_provider.dart';
import 'package:ai_food/Practice/task_class.dart';
import 'package:ai_food/Practice/widgets.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksUI extends StatefulWidget {
  const TasksUI({Key? key}) : super(key: key);

  @override
  State<TasksUI> createState() => _TasksUIState();
}

class _TasksUIState extends State<TasksUI> {
  @override
  Widget build(BuildContext context) {
    final practiceProvider =
        Provider.of<ListManagementProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks UI"),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: practiceProvider.taskParams.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final task = practiceProvider.taskParams[index];
          final taskNo = index + 1; // Task numbering starts from 1

          return practiceProvider.taskParams == null
              ? const Text("")
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            'Task #$taskNo',
                            size: 18,
                            bold: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        EditTaskDialog(task: task),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (task.status == Status.complete) {
                                    practiceProvider.updateTaskStatus(
                                        task, Status.incomplete);
                                  } else {
                                    practiceProvider.updateTaskStatus(
                                        task, Status.complete);
                                  }
                                },
                                icon: Icon(
                                  task.status == Status.complete
                                      ? Icons.check
                                      : Icons.check_box_outline_blank,
                                  color: task.status == Status.complete
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  practiceProvider.deleteTask(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        title: AppText(
                          task.name,
                          size: 18,
                          bold: FontWeight.bold,
                        ),
                        subtitle: AppText(
                          task.description,
                          color: Colors.grey[700],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: task.status == Status.complete
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: AppText(
                            practiceProvider.getStatusString(task.status),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
