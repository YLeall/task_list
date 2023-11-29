import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class TaskModel {

  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  int? color;
  int? remind;
  int? isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.color,
    required this.remind,
    required this.isCompleted,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'repeat': repeat,
      'color': color,
      'remind': remind,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      repeat: json['repeat'],
      color: json['color'] ,
      remind: json['remind'],
      isCompleted: json['isCompleted'],
    );
  }


  // @override
  // String toString() {
  //   return 'TaskModel(id: $id, title: $title, note: $note, date: $date, startTime: $startTime, endTime: $endTime, repeat: $repeat, color: $color, remind: $remind, isCompleted: $isCompleted)';
  // }
}
