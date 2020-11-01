class Todo {
  String title;
  String date;
  bool completed;

  Todo({
    this.title,
    this.date,
    this.completed = false,
  });

  Todo.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        date = map['date'],
        completed = map['completed'];

  updateTitle(title) {
    this.title = title;
  }

  updateSubTitle(dateTime) {
    this.date = dateTime;
  }

  Map toMap() {
    return {
      'title': title,
      'dateTime': date,
      'completed': completed,
    };
  }
}
