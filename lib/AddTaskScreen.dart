import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Tasks.dart';
import 'Theme.dart';

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
