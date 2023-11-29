import 'package:get/get.dart';
import 'package:task_list/src/pages/auth/controller/auth_controller.dart';
import '../../../models/task_model.dart';
import '../../../service/http_manager.dart';

class TaskRepository {
  final HttpManager _httpManager = HttpManager();
  final authController = Get.find<AuthController>();

  Future<void> addTask({required TaskModel? task}) async {
    final result = await _httpManager.restRequest(
        url: "https://tasklist-api-vczi.onrender.com/tasks",
        method: HttpMethods.post,
        body: task?.toJson(),
        headers: {
          'Authorization': 'Bearer ${authController.user.token}',
        });

    if (result.isNotEmpty) {
      print('adicionou ao banco');
    }
  }

  Future<({List<TaskModel>? tasks, String? error})> getTasks() async {
    final result = await _httpManager.restRequestList(
      url: "https://tasklist-api-vczi.onrender.com/tasks",
      method: HttpMethods.get,
      headers: {
        'Authorization': 'Bearer ${authController.user.token}',
      },
    );

    if (result.isNotEmpty) {
      final List<TaskModel> task = await Future.value(
          List<Map<String, dynamic>>.from(result)
              .map((e) => TaskModel.fromJson(e))
              .toList());

      return (
        tasks: task,
        error: null,
      );
    } else {
      return (
        tasks: null,
        error: 'Erro ao pegar as task',
      );
    }
  }

  Future<String> deleteTaskDb({required int id}) async {
    print(id);

    final result = await _httpManager.restRequest(
      url: "https://tasklist-api-vczi.onrender.com/tasks/$id",
      method: HttpMethods.delete,
      headers: {
        'Authorization': 'Bearer ${authController.user.token}',
      },
    );
    print(result);

    if (result.isEmpty) {
      return "Task deletada";
    } else {
      return "Erro ao deletar";
    }
  }


  Future<String> updateTaskDb({required TaskModel? task})async{
    final result = await _httpManager.restRequest(
      url: "https://tasklist-api-vczi.onrender.com/tasks/${task!.id}",
      method: HttpMethods.put,
      body: task.toJson(),
      headers: {
        'Authorization': 'Bearer ${authController.user.token}',
      },
    );

    print(result);

    if (result.isNotEmpty) {
      return "Task Atualizado";
    } else {
      return "Erro ao deletar";
    }

    

  }

}
