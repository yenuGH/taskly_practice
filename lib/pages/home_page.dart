import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _hiveboxTasks = "tasks";
  Box? _box;

  late double _deviceHeight;
  late double _deviceWidth;

  String? _newTaskContent;


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title : const Text(
          "TASKLY",
          style: TextStyle(
            fontSize: 35.0,
          ),  
        ),
        toolbarHeight: _deviceHeight * 0.15,
      ),

      body: TaskList(),

      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _addTaskButton(){
    return FloatingActionButton(
      onPressed:() => {
        _displayTaskCreateWindow(),
      },
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskCreateWindow (){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a new task!"),
          content: TextField(
            onSubmitted: (value) => {},
            onChanged: (value) => {
              setState(() {
                _newTaskContent = value;
              }),
            },
          ),
        );
      },
    );
  }

}