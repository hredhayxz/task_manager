import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Cancelled', 'Completed'];
  late String _selectedTask;
  bool updateTaskInProgress = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!;
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update task status successful!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Update task status has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16), child: Text('Update Status')),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedTask == taskStatusList[index];
                return Container(
                  color: isSelected ? Colors.green : Colors.transparent,
                  // Set the background color
                  child: ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                      setState(() {});
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Visibility(
                  visible: updateTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        updateTask(widget.task.sId!, _selectedTask);
                      },
                      child: const Text('Update'))))
        ],
      ),
    );
  }
}
