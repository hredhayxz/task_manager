import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/summary_count_model.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_list_tile.dart';
import 'package:task_manager/ui/widgets/user_profile_appbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary count data get failed.')));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Get new task data failed')));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess && response.statusCode == 200) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      getCountSummary();
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
              getCountSummary();
              getNewTasks();
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
              _getCountSummaryInProgress
                  ? const LinearProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _summaryCountModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return SummaryCard(
                              title:
                                  _summaryCountModel.data![index].sId ?? 'New',
                              number: _summaryCountModel.data![index].sum ?? 0,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        ),
                      ),
                    ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    getCountSummary();
                    getNewTasks();
                  },
                  child: _getNewTaskInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: _taskListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListTile(
                              data: _taskListModel.data![index],
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
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
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
            // Set the title text color here
          ),
        ),
        content: const Text(
          "Are you want to delete this item?",
          style: TextStyle(
            color: Colors.black, // Set the content text color here
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
              deleteTask(_taskListModel.data![index].sId!);
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
            // Set the title text color here
          ),
        ),
        content: const Text(
          "Are you want to edit status of this item?",
          style: TextStyle(
            color: Colors.black, // Set the content text color here
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
              showStatusUpdateBottomSheet(_taskListModel.data![index]);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
