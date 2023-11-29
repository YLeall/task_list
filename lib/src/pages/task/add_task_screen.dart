import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_list/src/models/task_model.dart';
import 'package:task_list/src/pages/commom_widgets/button_tile.dart';
import 'package:task_list/src/pages/commom_widgets/custom_text_field.dart';
import 'package:task_list/src/pages/task/controller/task_controller.dart';
import 'package:task_list/src/theme/theme.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final taskController = Get.find<TaskController>();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weakly",
    "Monthly",
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              CustomTextField(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleController,
              ),
              CustomTextField(
                title: 'Note',
                hint: 'Enter your note',
                controller: _noteController,
              ),
              CustomTextField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => {_getTimeFromUser(isStartTime: true)},
                        icon: const Icon(
                          Icons.access_time_rounded,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => {_getTimeFromUser(isStartTime: false)},
                        icon: const Icon(
                          Icons.access_time_rounded,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtTitleStyle,
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                      ),
                    );
                  }).toList(),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              CustomTextField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtTitleStyle,
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Wrap(
                        children: List<Widget>.generate(
                          3,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? Colors.blue
                                      : index == 1
                                          ? Colors.pink
                                          : Colors.yellow,
                                  child: _selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ButtonTile(
                    label: "Create Task",
                    onTap: () => _validateDate(),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  _addTaskToDb()async {
    await taskController.addTask(
      task: TaskModel(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      )
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      //taskController.getTasks();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 10,
        ),
        colorText: Colors.white,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
      );
    }
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      print('erro');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      print('Cancelado');
    } else {
      String formatedTime = pickedTime.format(context);
      if (isStartTime == true) {
        setState(() {
          _startTime = formatedTime;
        });
      } else {
        setState(() {
          _endTime = formatedTime;
        });
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
  //
}
