import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager/ui/state_managers/get_task_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final GetTasksController _getTasksController = Get.find<GetTasksController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTasksController.getTasks(Urls.inProgressTasks).then((value) {
        if (value == false) {
          Get.snackbar(
            'Failed',
            'In progress task data get failed!',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
          );
        }
      });
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _getTasksController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deletion successful!')));
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
            task: task,
            onUpdate: () {
              _getTasksController.getTasks(Urls.inProgressTasks);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Column(
            children: [
              const UserProfileAppBar(),
              Expanded(
                child: GetBuilder<GetTasksController>(
                    builder: (getTasksController) {
                  return getTasksController.getTaskInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount:
                              getTasksController.taskListModel.data?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data:
                                  getTasksController.taskListModel.data![index],
                              onDeleteTap: () {
                                deleteAlertDialogue(index);
                                //deleteTask(_taskListModel.data![index].sId!);
                              },
                              onEditTap: () {
                                editAlertDialogue(index);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteAlertDialogue(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Alert",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you want to delete this item?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              deleteTask(_getTasksController.taskListModel.data![index].sId!);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void editAlertDialogue(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Alert",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you want to edit status of this item?",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              showStatusUpdateBottomSheet(
                  _getTasksController.taskListModel.data![index]);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
