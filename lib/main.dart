import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'Task.dart';
import 'Tasks.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => new Tasks(),
      child: MyApp(),
    ),
  );
}

const primaryColor = Color(0xff6fa8dc);
const secondaryColor = Color(0xff39405B);

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
          body: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: size.height * .10,
                    margin: EdgeInsets.only(top: 40),
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

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.clear, color: secondaryColor),
                iconSize: 40,
              ),
              CupertinoTextField(
                controller: myController,
                autofocus: true,
                placeholder: 'Write task here',
                padding: EdgeInsets.only(left: 20),
                decoration: null,
                cursorColor: secondaryColor,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: CupertinoButton(
          onPressed: () {
            Provider.of<Tasks>(context, listen: false)
                .addToDo(title: myController.text, complete: false);
            Navigator.pop(context);
          },
          color: primaryColor,
          child: const Text(
            'Add',
            style: TextStyle(fontSize: 20, color: CupertinoColors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
