import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'Theme.dart';
import 'Task.dart';
import 'Tasks.dart';
import 'AddTaskScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => new Tasks(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return CupertinoApp(
      title: 'To-Do List',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var dateTime = DateTime.now();
    var date = DateFormat.yMMMEd().format(dateTime);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(date),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'To-Do List',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                            Icon(Icons.search, color: secondaryColor)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer<Tasks>(
                      builder: (context, tasks, child) => TaskList(
                        tasks: tasks.all,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                width: size.width,
                child: Center(
                  child: FloatingActionButton(
                    backgroundColor: primaryColor,
                    elevation: 2.0,
                    tooltip: 'Add To-Do',
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AddTaskScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key key, this.tasks}) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          ...this.tasks.map((task) {
            return TaskListItem(task: task);
          })
        ],
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem({Key key, this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        title: Text(
          task.title,
          style: task.isComplete
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : TextStyle(),
        ),
        trailing: Checkbox(
          value: task.isComplete,
          activeColor: primaryColor,
          onChanged: (value) {
            Provider.of<Tasks>(context, listen: false)
                .updateToDo(task: task, complete: value);
          },
        ),
      ),
    );
  }
}
