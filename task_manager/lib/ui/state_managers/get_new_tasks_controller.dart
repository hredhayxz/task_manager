import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class GetNewTasksController extends GetxController {
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  String message = '';

  bool get getNewTaskInProgress => _getNewTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTasks);
    _getNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
    } else {
      message = 'Get new task data failed!';
      update();
    }
  }
}
