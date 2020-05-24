import 'package:flutter/cupertino.dart';
import 'Task.dart';

class Tasks with ChangeNotifier {
  List<Task> all = new List();

  void addToDo({String title, bool complete}) {
    all.add(
      new Task(title: title, complete: complete),
    );
    notifyListeners();
  }

  void updateToDo({Task task, bool complete}) {
    int taskIndex = all.indexOf(task);
    all[taskIndex].complete = complete;
    notifyListeners();
  }
}
