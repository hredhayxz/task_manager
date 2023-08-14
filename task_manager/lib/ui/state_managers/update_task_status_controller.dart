import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool _updateTaskInProgress = false;

  bool get updateTaskInProgress => _updateTaskInProgress;

  Future<bool> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
      widget.onUpdate();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Update task status successful!')));
      }
    } else {
      return false;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Update task status has been failed')));
      }
    }
  }
}
