import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/index.dart';
import 'index.dart';

class PersonalList01Screen extends StatefulWidget {
  static const String routeName = "/personalList_screen";

  @override
  _PersonalList01ScreenState createState() => _PersonalList01ScreenState();
}

class _PersonalList01ScreenState extends State<PersonalList01Screen> {
  TextEditingController _textEditingController = new TextEditingController();
  List<Todo> items = new List<Todo>();

  ScrollController _controller;
  String message;
  bool showContainer;

  @override
  void initState() {
    super.initState();
    message = "";
    showContainer = true;

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    // _textEditingController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();

    _textEditingController.dispose();
    super.dispose();
  }

  _scrollListener() {
    // print(
    //     "_controller.offset => ${_controller.offset} = ${_controller.position.maxScrollExtent}");
    // print(
    //     "_controller.position.outOfRange => ${_controller.position.outOfRange}");

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        if (_textEditingController.text.isEmpty) showContainer = false;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
        showContainer = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // print("_textEditingController.text => ${_textEditingController.text}");

        if (_textEditingController.text.isEmpty && items.length > 0) {
          showContainer = false;
          setState(() {
            // _textEditingController.clear();
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Personal List"),
          elevation: 0.0,
        ),
        drawer: Drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (showContainer)
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    height: 80.0,
                    decoration: BoxDecoration(
                        gradient: new LinearGradient(
                      colors: [
                        Colors.deepOrangeAccent,
                        Colors.grey[200],
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      stops: [0.3, 1],
                    )),
                    child: Center(
                      child: TextField(
                          autofocus: true,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          controller: _textEditingController,
                          decoration: new InputDecoration(
                            hintText: "Enter Something",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                            ),
                            helperText: "Add Reminder",
                            helperStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          onSubmitted: (value) {
                            if (value != "") {
                              // addItem(Todo(title: value));
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectDateAndTimeScreen();
                                  }).then((dateTime) {
                                if (dateTime != null) {
                                  final DateTime now = dateTime;
                                  final DateFormat formatter =
                                      DateFormat('dd-MM-yyyy At hh:mm a');
                                  final String tempDate = formatter.format(now);
                                  // print(tempDate);
                                  addItem(
                                    Todo(
                                      title: value,
                                      date: tempDate,
                                    ),
                                  );
                                  _textEditingController.clear();
                                }
                              });
                            }
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800)),
                    ),
                  )
                : Offstage(),
            (items.length > 0)
                ? Expanded(
                    child: Container(
                      color: Colors.black,
                      child: ReorderableListView(
                        // onReorder: _onReorder,
                        onReorder: (int index, int targetPosition) {
                          changeItemCompleteness(items[index], index);
                        },
                        scrollDirection: Axis.vertical,
                        scrollController: _controller,
                        children: List.generate(
                          items.length,
                          (index) {
                            Todo todo = items[index];
                            Key key = UniqueKey();
                            return todo.completed
                                ? buildCompletedListTile(todo, index, key)
                                : buildItem(todo, index, key);
                          },
                        ),
                      ),
                    ),
                  )
                : emptyList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 32.0,
          ),
          backgroundColor: Colors.red,
          // onPressed: () => goToNewItemView(),
          onPressed: () {
            showContainer = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget emptyList() {
    return Expanded(
      child: Center(
        child: Text(
          'No items in list',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget buildItem(Todo item, int index, key) {
    return Dismissible(
      key: key,
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      child: buildListTile(item, index),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // print(direction);
          removeItemFromList(item, index);
        } else if (direction == DismissDirection.startToEnd) {
          // print(direction);
          changeItemCompleteness(item, index);
        }
      },
    );
  }

  void changeItemCompleteness(Todo item, int index) {
    setState(() {
      item.completed = !item.completed;

      int newIndex = items.length;
      setState(
        () {
          if (newIndex > index) {
            newIndex -= 1;
          }
          final Todo item = items.removeAt(index);
          items.insert(newIndex, item);

          _showContainer();
        },
      );
    });
  }

  _showContainer() {
    bool _tempShowContainerFlag = false;
    for (int i = 0; i < items.length; i++) {
      if (items[i].completed) {
        _tempShowContainerFlag = true;
      } else {
        _tempShowContainerFlag = false;
        break;
      }
    }
    showContainer = _tempShowContainerFlag;
  }

  Widget buildCompletedListTile(Todo item, int index, Key key) {
    return Container(
      key: key,
      padding: EdgeInsets.all(8.0),
      child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              item.title,
              key: key,
              style: TextStyle(
                color: item.completed ? Colors.grey : Colors.white,
                decoration: item.completed ? TextDecoration.lineThrough : null,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          subtitle: Text(
            item.date.toString(),
            key: Key('item-$index'),
            style: TextStyle(
              color: item.completed ? Colors.grey : Colors.black,
              decoration: item.completed ? TextDecoration.lineThrough : null,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  void goToNewItemView() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (context) {
            return NewTodoView();
          },
          fullscreenDialog: true),
    )
        .then((title) {
      if (title != null) {
        addItem(Todo(title: title));
      }
    });
  }

  void addItem(Todo item) {
    items.insert(0, item);
    showContainer = false;
    setState(() {});
  }

  void removeItemFromList(item, int index) {
    items.remove(item);
    if (items.isEmpty) {
      showContainer = true;
    } else {
      _showContainer();
    }
    setState(() {});
  }

  // void _onReorder(int oldIndex, int newIndex) {
  //   // print("items[oldIndex] = ${items[oldIndex]}");
  //   changeItemCompleteness(items[oldIndex], oldIndex);
  //   // setState(
  //   //   () {
  //   //     if (newIndex > oldIndex) {
  //   //       newIndex -= 1;
  //   //     }
  //   //     final Todo item = items.removeAt(oldIndex);
  //   //     items.insert(newIndex, item);
  //   //   },
  //   // );
  // }

  Widget buildListTile(Todo item, int index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
        color: Colors.red,
        gradient: new LinearGradient(
          colors: [
            Colors.deepOrangeAccent,
            Colors.grey[200],
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          stops: [0.3, 1],
        ),
      ),
      child: ListTile(
        // onTap: () => changeItemCompleteness(item, index),
        // onLongPress: () => goToEditItemView(item),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            item.title.toString(),
            key: Key('item-$index'),
            style: TextStyle(
              color: item.completed ? Colors.grey : Colors.black,
              decoration: item.completed ? TextDecoration.lineThrough : null,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        subtitle: Text(
          item.date.toString(),
          key: Key('item-$index'),
          style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
