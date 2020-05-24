class Task {
  String _title;
  bool _complete;

  Task({String title, bool complete}) {
    this._title = title;
    this._complete = complete;
  }

  get title {
    return _title;
  }

  set title(String title) {
    this._title = title;
  }

  get isComplete {
    return _complete;
  }

  set complete(bool complete) {
    this._complete = complete;
  }
}
