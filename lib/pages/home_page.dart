import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late double _deviceHeight;
  late double _deviceWidth;

  String? _newTaskContent;

  final String hiveboxTasks = "tasks";
  Box? _box;

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

      body: _taskListView(),

      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _taskListView(){
    return FutureBuilder(
      future: Hive.openBox(hiveboxTasks),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _box = snapshot.data;
          return _taskList();
        }
        else {
          return CircularProgressIndicator();  
        }
      },
    );
  }

  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            "Task 1",
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

  String _getFormattedDateTime(){
    DateTime dateTime = DateTime.now();
    String formattedDateTime = DateFormat.yMMMMEEEEd().format(dateTime);  
    return "Date Created: $formattedDateTime";
  }
}