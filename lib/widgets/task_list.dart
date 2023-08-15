import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:taskly/models/task.dart';

class TaskList extends ListView {
  final String _hiveboxTasks = "tasks";
  Box? _box;
  String? _newTaskContent;

  @override
  Widget build(BuildContext context){
    return _taskListView();
  }
  
  Widget _taskListView(){
    return FutureBuilder(
      future: Hive.openBox(_hiveboxTasks),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _box = snapshot.data;
          return _taskList();
        }
        else {
          return const CircularProgressIndicator();  
        }
      },
    );
  }

  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "Does this work",
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(_getFormattedDateTime()),
          trailing: const Icon(
            Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text(
            "Task 2",
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(_getFormattedDateTime()),
          trailing: const Icon(
            Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  String _getFormattedDateTime(){
    DateTime dateTime = DateTime.now();
    String formattedDateTime = DateFormat.yMMMMEEEEd().format(dateTime);  
    return "Date Created: $formattedDateTime";
  }
}