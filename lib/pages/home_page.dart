import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskly/models/task.dart';

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

      body: _taskListView(),

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
            onSubmitted: (value) {
              if (_newTaskContent != null){
                Task task = Task(
                  content: value,
                  timestamp: DateTime.now(),
                  completed: false,
                );

                _box!.add(task.toMap());

                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });

              }
            },
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
    List tasks = _box!.values.toList();

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        Task task = Task.fromMap(tasks[index]);

        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
                decoration: task.completed ? TextDecoration.lineThrough : null,
            ),
          ),

          subtitle: Text(
            _getFormattedDateTime(task.timestamp),
          ),

          trailing: Icon(
            task.completed ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
        );
      },
    );
  }

  String _getFormattedDateTime(DateTime dateTime){
    String formattedDateTime = DateFormat.yMMMMEEEEd().format(dateTime);  
    return "Date Created: $formattedDateTime";
  }

}