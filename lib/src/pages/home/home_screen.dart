import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_list/src/models/task_model.dart';
import 'package:task_list/src/pages/commom_widgets/button_tile.dart';
import 'package:task_list/src/pages/home/components/task_tile.dart';
import 'package:task_list/src/pages/task/controller/task_controller.dart';
import 'package:task_list/src/pages_routes/app_pages.dart';
import 'package:task_list/src/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  final _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.nightlight_round,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.offAllNamed(PagesRoutes.signInRoute);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //
          _addTaskBar(),
          //
          _addDateBar(),
          //
          const SizedBox(
            height: 15,
          ),
          //
          _showTasks(),
        ],
      ),
    );
  }

//
  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, index) {
              TaskModel task = _taskController.taskList[index];
              print(_taskController.taskList[index].toJson());

              if (task.repeat == "Daily") {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("apertei");
                              _showBottomSheet(context, _taskController.taskList[index]);
                            },
                            child: TaskTile(_taskController.taskList[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("apertei");
                              _showBottomSheet(
                                  context, _taskController.taskList[index]);
                            },
                            child: TaskTile(_taskController.taskList[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
              //
            },
          );
        },
      ),
    );
  }

  //
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: headingStyle,
                ),
              ],
            ),
          ),
          ButtonTile(
            label: "+ add Task",
            onTap: () async {
              await Get.toNamed(
                PagesRoutes.taskRoute,
              );
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  //
  _showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completa",
                    onTap: () {
                      _taskController.updateTask(task: task);
                      Get.back();
                    },
                    clr: Colors.blue,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Deletar Task",
              onTap: () {
                _taskController.deleteTask(idTask: task.id!);
                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Fechar",
              onTap: () {
                Get.back();
              },
              clr: Colors.red,
              context: context,
              isClose: true,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: isClose == true ? Colors.grey.shade300 : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: const Color(0xFF4e5ae8),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
      ),
    );
  }
}


// GestureDetector(
//                 onTap: () {
//                   _taskController.deleteTask(
//                       idTask: _taskController.taskList[index].id!);
//                   _taskController.getTasks();
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   color: Colors.green,
//                   margin: const EdgeInsets.only(
//                     bottom: 10,
//                   ),
//                   child: Text(
//                     "${_taskController.taskList[index].title} ${_taskController.taskList[index].id}",
//                   ),
//                 ),
//               );
