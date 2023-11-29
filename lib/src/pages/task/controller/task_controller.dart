import 'package:get/get.dart';
import 'package:task_list/src/models/task_model.dart';
import 'package:task_list/src/pages/task/repository/task_repository.dart';

class TaskController extends GetxController {
  final taskRepository = TaskRepository();
  var taskList = <TaskModel>[].obs;

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  Future<void> addTask({required TaskModel? task}) async {
    await taskRepository.addTask(task: task);
  }

  Future<void> getTasks() async {
    final (:tasks, :error) = await taskRepository.getTasks();
    print(tasks?.isNotEmpty);
    final isNotEmptyTasks = tasks?.isBlank;
    if (tasks?.isNotEmpty != null) {
      print("oi");
      taskList.value = tasks!;
    }
    else{
      print("vazio");
      taskList.value = [];
    }
  }

  Future<void> deleteTask({required int idTask}) async {
    final result = await taskRepository.deleteTaskDb(id: idTask);
    if (result == "Task deletada") {
      print("deletou");
      getTasks();
    } else {
      print("erro ao deletar");
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    task.isCompleted = 1;
    final result = await taskRepository.updateTaskDb(task: task);
    if (result == "Task Atualizado") {
      print('atualizouuu');
      getTasks();
    }
  }
  //
}
