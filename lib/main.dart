import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return CupertinoApp(
      title: 'To-Do List',
      // theme: ThemeData(buttonColor: Colors.blueGrey),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _todos = new List();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                    // color: Colors.blue[600],
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Saturday, May 23'),
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
                            Icon(Icons.search)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      children: <Widget>[
                        ..._todos.map(
                          (text) => Card(
                            elevation: 3.0,
                            child: ListTile(
                              title: Text(text),
                              trailing: Checkbox(
                                value: false,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                width: size.width,
                child: Center(
                  child: FloatingActionButton(
                    tooltip: 'Add To-Do',
                    child: Icon(Icons.add),
                    onPressed: () {
                      _addTodo();
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AddTodoScreen(),
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

  void _addTodo() {
    setState(() {
      _todos.add('Hello');
    });
  }
}

class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                icon: Icon(CupertinoIcons.clear),
                iconSize: 40,
              ),
              CupertinoTextField(
                autofocus: true,
                placeholder: 'Write task here',
                padding: EdgeInsets.only(left: 20),
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: CupertinoColors.activeBlue,
        child: const Text(
          'Add',
          style: TextStyle(fontSize: 20, color: CupertinoColors.white),
        ),
      ),
    );
  }
}
