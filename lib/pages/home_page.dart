import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Widget _taskListView() {
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
        print("Add Task button pressed."),
      },
      child: const Icon(Icons.add),
    );
  }

  String _getFormattedDateTime(){
    DateTime dateTime = DateTime.now();
    String formattedDateTime = DateFormat.yMMMMEEEEd().format(dateTime);  
    return "Date Created: $formattedDateTime";
  }
}