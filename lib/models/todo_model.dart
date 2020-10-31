class Todo {
  String title;
  String dateTime;
  bool completed;

  Todo({
    this.title,
    this.dateTime,
    this.completed = false,
  });

  Todo.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        dateTime = map['dateTime'],
        completed = map['completed'];

  updateTitle(title) {
    this.title = title;
  }

  updateSubTitle(dateTime) {
    this.dateTime = dateTime;
  }

  Map toMap() {
    return {
      'title': title,
      'dateTime': dateTime,
      'completed': completed,
    };
  }
}
